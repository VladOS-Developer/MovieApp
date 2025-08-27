//
//  MockTrailerRepository.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

final class MockTrailerRepository: TrailerRepositoryProtocol {
    static let shared = MockTrailerRepository()
    
    func fetchTrailer(for movieId: Int) -> [Trailer] {
        Trailer.mockTrailer()
    }
}
