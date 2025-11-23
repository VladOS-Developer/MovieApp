//
//  TVSeriesDetailsRepository.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

final class TVDetailsRepository: TVDetailsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchTopRatedTVSeries(page: Int = 1) async throws -> [TVDetails] {
        let response: TVSeriesDetailsResponseDTO = try await networkService.request(.tvTopRated(page: page))
        return response.results.map { TVDetails(dto: $0) }
    }

    func fetchPopularTVSeries(page: Int = 1) async throws -> [TVDetails] {
        let response: TVSeriesDetailsResponseDTO = try await networkService.request(.tvPopular(page: page))
        return response.results.map { TVDetails(dto: $0) }
    }

    func fetchTVSeriesDetails(byId id: Int) async throws -> TVDetails {
        let response: TVSeriesDetailsDTO = try await networkService.request(.tvDetails(id))
        return TVDetails(dto: response)
    }
}
