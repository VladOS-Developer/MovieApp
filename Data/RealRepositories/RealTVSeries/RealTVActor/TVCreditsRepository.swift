//
//  TVCreditsRepository.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import Foundation

final class TVCreditsRepository: TVCreditsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCredits(for tvId: Int) async throws -> TVCredits {
        let dto: TVCreditsResponseDTO = try await networkService.request(.tvCredits(tvId))
        return TVCredits(dto: dto)
    }
}
