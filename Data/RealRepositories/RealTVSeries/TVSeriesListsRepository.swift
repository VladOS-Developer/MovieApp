//
//  TVSeriesListsRepository.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

final class TVSeriesListsRepository: TVSeriesListsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTVSeriesLists() async throws -> [TVSeriesLists] {
//        let seriesRandomPage = Int.random(in: 1...50)
        let response: TVSeriesListsResponseDTO = try await networkService.request(.tvTopRated(page: 1))
        return response.results.map { TVSeriesLists(dto: $0) }
    }
}
