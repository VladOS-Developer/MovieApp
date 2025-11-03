//
//  MockTVCreditsRepository.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import Foundation

final class MockTVCreditsRepository: TVCreditsRepositoryProtocol {
    static let shared = MockTVCreditsRepository()
    
    func fetchCredits(for tvId: Int) async throws -> TVCredits {
        return TVCredits.mockTVCredits()
    }
}
