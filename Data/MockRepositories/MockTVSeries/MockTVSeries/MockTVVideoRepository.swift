//
//  MockTVVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

final class MockTVVideoRepository: TVVideoRepositoryProtocol {
    static let shared = MockTVVideoRepository()
    
    func fetchTVVideos(for tvId: Int) async throws -> [TVVideo] {
        return TVVideo.mockTVVideos(for: tvId)
    }
    
    func fetchTrendingTVVideos() async throws -> [TVVideo] {
        return TVVideo.mockTVTrendingVideos()
    }
}
