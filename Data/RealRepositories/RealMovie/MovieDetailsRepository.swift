//
//  MovieDetailsRepository.swift
//  MovieApp
//
//  Created by VladOS on 24.09.2025.
//

import Foundation

final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTopMovieDetails(page: Int = 1) async throws -> [MovieDetails] {
        let response: MoviesDetailsResponseDTO = try await networkService.request(.topRatedMovies(page: page))
        return response.results.map { MovieDetails(dto: $0) }
    }
    
    func fetchUpcomingMovieDetails(page: Int = 1) async throws -> [MovieDetails] {
        let response: MoviesDetailsResponseDTO = try await networkService.request(.upcomingMovies(page: page))
        return response.results.map { MovieDetails(dto: $0) }
    }
    
    func fetchMovieDetails(byGenre id: Int, page: Int = 1) async throws -> [MovieDetails] {
        let response: MoviesDetailsResponseDTO = try await networkService.request(.moviesByGenre(id, page: page))
        return response.results.map { MovieDetails(dto: $0) }
    }
    
    func fetchMovieDetails(byId id: Int) async throws -> MovieDetails {
        let response: MovieDetailsDTO = try await networkService.request(.movieDetails(id))
        return MovieDetails(dto: response)
    }
    
}
