//
//  MockTVSeriesRepository.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

final class MockTVSeriesRepository: TVSeriesRepositoryProtocol {
    static let shared = MockTVSeriesRepository()
    
    func fetchTVSeriesTopRate(page: Int) async throws -> [TVSeries] {
        return TVSeries.mockSeriesTopRate()
    }
    
    func fetchTVSeriesPopular(page: Int) async throws -> [TVSeries] {
        return TVSeries.mockSeriesPopular()
    }
    
//    func fetchCombinedTVSeries() async throws -> [TVSeries] {
//        let combined = (try await fetchTVSeriesTopRate(page: 1)) + (try await fetchTVSeriesPopular(page: 1))
//        let unique = Array(Set(combined))
//        return unique
//    }
    
    func fetchTVSeries() async throws -> [TVSeries] {
        return TVSeries.mockSeriesTopRate()
    }
    
    func searchTVSeries(query: String, page: Int) async throws -> [TVSeries] {
        let all = TVSeries.mockSeriesTopRate()
        let filtered = all.filter { $0.name.lowercased().contains(query.lowercased()) }
        return filtered
    }
}
