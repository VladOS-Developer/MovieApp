//
//  MockTVVideoRepository.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

final class MockTVVideoRepository: TVVideoRepositoryProtocol {
    
    func fetchTVVideos(for tvId: Int) async throws -> [TVVideo] {
        return TVVideo.mockTVVideos(for: tvId)
    }
}
