//
//  MovieVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 10.09.2025.
//

import Foundation

final class MovieVideoRepository: MovieVideoRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchMovieVideo(for movieId: Int) async throws -> [MovieVideo] {
        let response: MovieVideosResponseDTO = try await networkService.request(.movieVideos(movieId))
        return response.results.map { MovieVideo(dto: $0) } // маппинг в домен
    }
    
    func fetchTrendingMovieVideos() async throws -> [MovieVideo] {
        let trending: TopRatedResponseDTO = try await networkService.request(.trendingMovies(page: 1))
        var allVideos: [MovieVideo] = []
        
        let types = ["Trailer", "Teaser", "Clip"]
        let sites = ["YouTube", "Vimeo"]
        
        try await withThrowingTaskGroup(of: [MovieVideo].self) { group in
            for movie in trending.results {
                group.addTask {
                    let videos = try await self.fetchMovieVideo(for: movie.id)
                    return videos.filter {
                        types.contains($0.type) &&
                        sites.contains($0.site)
                    }
                }
            }
            
            for try await items in group {
                allVideos.append(contentsOf: items)
            }
        }
        
        return allVideos
    }
    
}
