//
//  GenreRepository.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import UIKit

final class GenreRepository: GenreRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchGenres() async throws -> [Genres] {
        let response: GenresResponseDTO = try await networkService.request(.genres)
        return response.genres.map { Genres(dto: $0) }
    }
    
}
