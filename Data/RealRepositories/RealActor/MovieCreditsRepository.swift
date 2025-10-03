//
//  MovieCreditsRepository.swift
//  MovieApp
//
//  Created by VladOS on 24.09.2025.
//

import Foundation

final class MovieCreditsRepository: MovieCreditsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCredits(for movieId: Int) async throws -> MovieCredits {
        let dto: MovieCreditsResponseDTO = try await networkService.request(.movieCredits(movieId))
        return MovieCredits(dto: dto)
    }
    
}
