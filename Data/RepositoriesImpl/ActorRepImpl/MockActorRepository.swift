//
//  MockActorRepository.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

final class MockActorRepository: ActorRepositoryProtocol {
    static let shared = MockActorRepository()
    
    private init() {}

    func fetchActorDetails(by id: Int) -> Actor {
        return Actor.mockActor()
    }

    func fetchActorMovies(by id: Int) -> [ActorMovie] {
        return ActorMovie.mockMovies()
    }
}
