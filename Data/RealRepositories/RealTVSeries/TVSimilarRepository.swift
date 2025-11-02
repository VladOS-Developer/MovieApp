//
//  TVSimilarRepository.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

final class TVSimilarRepository: TVSimilarRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchSimilarTVShows(for tvId: Int) async throws -> [TVSimilar] {
        let response: TVSeriesSimilarResponseDTO = try await networkService.request(.tvSimilar(tvId))
        return response.results.map { TVSimilar(dto: $0) }
    }
}
