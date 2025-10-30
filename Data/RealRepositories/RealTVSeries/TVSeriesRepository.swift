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
    
    func fetchTVSeriesLists() async throws -> [TVSeries] {
//        let seriesRandomPage = Int.random(in: 1...50)
        let response: TVSeriesResponseDTO = try await networkService.request(.tvTopRated(page: 1))
        return response.results.map { TVSeries(dto: $0) }
    }
    
    func searchTVSeries(query: String, page: Int) async throws -> [TVSeries] {
        let response: TVSeriesResponseDTO = try await networkService.request(.searchTVSeries(query: query, page: page))
        return response.results.map { TVSeries(dto: $0) }
    }
    
}
