//
//  MockActorRepository.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

final class MockActorRepository: ActorRepositoryProtocol {
    static let shared = MockActorRepository()
    
    func fetchActorDetails(by id: Int) async throws -> ActorDetails {
        return ActorDetails.mockActor(id: id)
    }
    
    func fetchActorMovies(by id: Int) async throws -> [ActorMovie] {
        return ActorMovie.mockActorMovies()
    }
    
    func fetchActorImages(by id: Int) async throws -> [ActorImages] {
        return ActorImages.mockActorImages()
    }
}
