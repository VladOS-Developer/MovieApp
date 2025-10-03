//
//  ActorRepository.swift
//  MovieApp
//
//  Created by VladOS on 24.09.2025.
//

import Foundation

final class ActorRepository: ActorRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchActorDetails(by id: Int) async throws -> ActorDetails {
        let dto: ActorDetailsDTO = try await networkService.request(.actorDetails(id))
        return ActorDetails(dto: dto)
    }
    
    func fetchActorMovies(by id: Int) async throws -> [ActorMovie] {
        let dto: ActorMoviesResponseDTO = try await networkService.request(.actorMovies(id))
        return dto.cast.map { ActorMovie(dto: $0) }
    }
    
    func fetchActorImages(by id: Int) async throws -> [ActorImages] {
        let dto: ActorImagesResponseDTO = try await networkService.request(.actorImages(id))
        return dto.profiles.map { ActorImages(dto: $0) }
    }
}
