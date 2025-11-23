//
//  TVVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

final class TVVideoRepository: TVVideoRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTVVideos(for tvId: Int) async throws -> [TVVideo] {
        let response: TVSeriesVideosResponseDTO = try await networkService.request(.tvVideos(tvId))
        print("DEBUG: Decoded \(response.results.count) TV Videos")
        return response.results.map { TVVideo(dto: $0) }
    }
    
    
    func fetchTrendingTVVideos() async throws -> [TVVideo] {
        let trendingResponse: TVSeriesTopRateResponseDTO = try await networkService.request(.tvTrending(page: 1))
        let series = trendingResponse.results
        
        var allVideos: [TVVideo] = []
        
        let types = ["Trailer", "Teaser", "Clip"]
        let sites = ["YouTube", "Vimeo"]
        
        try await withThrowingTaskGroup(of: [TVVideo].self) { group in
            for tv in series {
                group.addTask {
                    let videos = try await self.fetchTVVideos(for: tv.id)
                    
                    // Фильтр видео
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
