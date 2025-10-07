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
    
    func fetchTopMovieDetails(page: Int) async throws -> [MovieDetails] {
        let response: MoviesListResponseDTO = try await networkService.request(.topRatedMovies(page: 1))
        return response.results.map { MovieDetails(dto: $0) }
    }
    
    func fetchUpcomingMovieDetails(page: Int) async throws -> [MovieDetails] {
        let response: MoviesListResponseDTO = try await networkService.request(.upcomingMovies(page: 1))
        return response.results.map { MovieDetails(dto: $0) }
    }
    
    func fetchMovieDetails(byGenre id: Int, page: Int) async throws -> [MovieDetails] {
        let response: MoviesListResponseDTO = try await networkService.request(.moviesByGenre(id, page: 1))
        return response.results.map { MovieDetails(dto: $0) }
    }
    
    func fetchMovieDetails(byId id: Int) async throws -> MovieDetails {
        let response: MovieDetailsDTO = try await networkService.request(.movieDetails(id))
        return MovieDetails(dto: response)
    }
    
}
