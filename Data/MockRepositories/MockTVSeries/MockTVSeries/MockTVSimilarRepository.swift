//
//  MockTVSimilarRepository.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

final class MockTVSimilarRepository: TVSimilarRepositoryProtocol {
    static let shared = MockTVSimilarRepository()
    
    func fetchSimilarTVShows(for tvId: Int) async throws -> [TVSimilar] {
        TVSimilar.mockTVSimilar(for: tvId)
    }
}
