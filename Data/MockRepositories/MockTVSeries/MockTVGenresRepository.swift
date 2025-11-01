//
//  MockTVGenresRepository.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

final class MockTVGenresRepository: TVGenresRepositoryProtocol {
    static let shared = MockTVGenresRepository()
    
    func fetchTVGenres() async throws -> [TVSeriesGenres] {
        return TVSeriesGenres.mockTVGenres()
    }
}
