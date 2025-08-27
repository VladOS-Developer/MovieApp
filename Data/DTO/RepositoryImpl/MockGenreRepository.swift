//
//  MockGenreRepository.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

final class MockGenreRepository: GenreRepositoryProtocol {
    static let shared = MockGenreRepository()
    
    func fetchGenres() -> [Genre] {
        Genre.mockGenres()
    }
    
}
