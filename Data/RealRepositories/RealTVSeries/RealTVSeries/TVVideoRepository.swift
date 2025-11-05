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
        return response.results.map { TVVideo(dto: $0) }
    }
    
    func fetchTrendingTVVideos() async throws -> [TVVideo] {
        // Получаем трендовые сериалы
        let trendingResponse: TopRatedResponseDTO = try await networkService.request(.tvTrending(page: 1))
        let series = trendingResponse.results
        var allVideos: [TVVideo] = []
        
        // Для каждого сериала подгружаем трейлеры
        try await withThrowingTaskGroup(of: [TVVideo].self) { group in
            for tv in series {
                group.addTask {
                    let videos = try await self.fetchTVVideos(for: tv.id)
                    // фильтруем только трейлеры (официальные видео, YouTube)
                    return videos.filter {
                        $0.type == "Trailer" &&
                        $0.site == "YouTube"
                    }
                }
            }
            
            for try await tvVideos in group {
                allVideos.append(contentsOf: tvVideos)
            }
        }
        
        // Ограничиваем по количеству (если нужно)
        return Array(allVideos.prefix(15))
    }
}
