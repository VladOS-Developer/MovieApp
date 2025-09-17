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

    func fetchActorDetails(by id: Int) -> ActorDetails {
        return ActorDetails.mockActor(id: id)
    }

    func fetchActorMovies(by id: Int) -> [ActorMovie] {
        return ActorMovie.mockActorMovies()
    }
    
    func fetchActorImages(by id: Int) -> [ActorImages] {
        return ActorImages.mockActorImages()
    }
}
