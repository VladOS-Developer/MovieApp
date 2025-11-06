//
//  TVSeriesRepository.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

final class TVSeriesRepository: TVSeriesRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTVSeriesTopRate(page: Int) async throws -> [TVSeries] {
        let seriesRandomPage = Int.random(in: 1...50)
        let response: TVSeriesTopRateResponseDTO = try await networkService.request(.tvTopRated(page: seriesRandomPage))
        print("DEBUG: Decoded \(response.results.count) TV Top Rated")
        return response.results.map { TVSeries(dto: $0) }
    }
    
    func fetchTVSeriesPopular(page: Int) async throws -> [TVSeries] {
        let response: TVSeriesTopRateResponseDTO = try await networkService.request(.tvPopular(page: page))
        print("DEBUG: Decoded \(response.results.count) TV Popular")
        return response.results.map { TVSeries(dto: $0) }
    }
    
    func fetchTVSeries() async throws -> [TVSeries] {
        async let topRated = fetchTVSeriesTopRate(page: 1)
        async let popular = fetchTVSeriesPopular(page: 1)
        
        let (top, pop) = try await (topRated, popular)
        
        // Объединяем и убираем дубли по id
        let combined = (top + pop).reduce(into: [Int: TVSeries]()) { dict, series in
            dict[series.id] = series
        }.map { $0.value }
        
        print("DEBUG: Combined TVSeries count = \(combined.count)")
        return combined
    }
    
    func searchTVSeries(query: String, page: Int) async throws -> [TVSeries] {
        let response: TVSeriesTopRateResponseDTO = try await networkService.request(.searchTVSeries(query: query, page: page))
        print("DEBUG: Decoded \(response.results.count) TV series")
        return response.results.map { TVSeries(dto: $0) }
    }
    
}
