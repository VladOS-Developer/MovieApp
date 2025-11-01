//
//  TVGenresRepository.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

final class TVGenresRepository: TVGenresRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTVGenres() async throws -> [TVSeriesGenres] {
        let response: TVSeriesGenresResponseDTO = try await networkService.request(.tvGenres)
        return response.genres.map { TVSeriesGenres(dto: $0) }
    }
}
