//
//  TVActorRepository.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

final class TVActorRepository: TVActorRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchActorTVSeries(by id: Int) async throws -> [TVActorMovie] {
        let dto: TVSeriesActorResponseDTO = try await networkService.request(.actorTVSeries(id))
        return dto.cast.map { TVActorMovie(tvDTO: $0) }
    }
}
