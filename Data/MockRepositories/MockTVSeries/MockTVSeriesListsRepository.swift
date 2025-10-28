//
//  MockTVSeriesListsRepository.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

final class MockTVSeriesListsRepository: TVSeriesListsRepositoryProtocol {
    static let shared = MockTVSeriesListsRepository()
    
    func fetchTVSeriesLists() async throws -> [TVSeriesLists] {
        return TVSeriesLists.mockSeriesList()
    }
}
