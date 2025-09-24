//
//  MockMovieCreditsRepository.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

final class MockMovieCreditsRepository: MovieCreditsRepositoryProtocol {
    static let shared = MockMovieCreditsRepository()
    
    func fetchCredits(for movieId: Int) async throws -> MovieCredits {
        return MovieCredits.mockCredits()
    }
    
}
