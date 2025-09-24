//
//  ActorRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

protocol ActorRepositoryProtocol: AnyObject {
    
    func fetchActorDetails(by id: Int) async throws -> ActorDetails
    func fetchActorMovies(by id: Int) async throws -> [ActorMovie]
    func fetchActorImages(by id: Int) async throws -> [ActorImages]
}
