//
//  MockTVSeriesRepository.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

final class MockTVSeriesRepository: TVSeriesRepositoryProtocol {
    static let shared = MockTVSeriesRepository()
    
    func fetchTVSeriesLists() async throws -> [TVSeries] {
        return TVSeries.mockSeriesList()
    }
    
    func searchTVSeries(query: String, page: Int) async throws -> [TVSeries] {
        let all = TVSeries.mockSeriesList()
        let filtered = all.filter { $0.name.lowercased().contains(query.lowercased()) }
        return filtered
    }
}
