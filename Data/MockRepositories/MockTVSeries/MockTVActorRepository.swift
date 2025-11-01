//
//  MockTVActorRepository.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

final class MockTVActorRepository: TVActorRepositoryProtocol {
    
    func fetchActorTVSeries(by id: Int) async throws -> [TVActorMovie] {
        return TVActorMovie.mockActorSeries()
    }
}
