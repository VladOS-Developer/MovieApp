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
            // Получаем трендовые фильмы
            let trendingResponse: TopRatedResponseDTO = try await networkService.request(.trendingMovies(page: 1))
            let movies = trendingResponse.results
            var allVideos: [MovieVideo] = []
            
            // Для каждого фильма подгружаем трейлеры
            try await withThrowingTaskGroup(of: [MovieVideo].self) { group in
                for movie in movies {
                    group.addTask {
                        let videos = try await self.fetchMovieVideo(for: movie.id)
                        // фильтруем только трейлеры (официальные видео, YouTube)
                        return videos.filter {
                            $0.type == "Trailer" &&
                            $0.site == "YouTube"
                        }
                    }
                }
                
                for try await movieVideos in group {
                    allVideos.append(contentsOf: movieVideos)
                }
            }
            
            // Ограничиваем по количеству (если нужно)
            return Array(allVideos.prefix(15))
        }
    
}
