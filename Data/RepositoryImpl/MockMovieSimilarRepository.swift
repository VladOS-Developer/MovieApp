//
//  MockMovieSimilarRepository.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import Foundation

final class MockMovieSimilarRepository: MovieSimilarRepositoryProtocol {
    static let shared = MockMovieSimilarRepository()
    
    func fetchSimilarMovie(for movieId: Int) -> [MovieSimilar] {
        MovieSimilar.mockSimilarMovies()
    }
}
