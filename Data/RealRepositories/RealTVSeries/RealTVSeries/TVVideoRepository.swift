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
        // Получаем трендовые сериалы
        let trendingResponse: TVSeriesTopRateResponseDTO = try await networkService.request(.tvTrending(page: 1))
        print("DEBUG: TVVideoRepository.tvTrending.results.count = \(trendingResponse.results.count)")

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
