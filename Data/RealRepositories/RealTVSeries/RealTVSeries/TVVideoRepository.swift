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
}
