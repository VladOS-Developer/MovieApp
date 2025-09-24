//
//  MovieSimilarRepository.swift
//  MovieApp
//
//  Created by VladOS on 24.09.2025.
//

import UIKit

final class MovieSimilarRepository: MovieSimilarRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchSimilarMovie(for movieId: Int) async throws -> [MovieSimilar] {
        let response: MoviesSimilarResponseDTO = try await networkService.request(.movieSimilar(movieId))
        return response.results.map { MovieSimilar(dto: $0) } // маппинг в домен
    }
}
