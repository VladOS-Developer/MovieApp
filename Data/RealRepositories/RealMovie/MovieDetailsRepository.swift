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
    
    func fetchTopMovieDetails() async throws -> [MovieDetails] {
        let response: MoviesListResponseDTO = try await networkService.request(.topRatedMovies)
        return response.results.map { MovieDetails(dto: $0) }
    }
    
    func fetchUpcomingMovieDetails() async throws -> [MovieDetails] {
        let response: MoviesListResponseDTO = try await networkService.request(.upcomingMovies)
        return response.results.map { MovieDetails(dto: $0) }
    }
    
    func fetchMovieDetails(byGenre id: Int) async throws -> [MovieDetails] {
        let response: MoviesListResponseDTO = try await networkService.request(.moviesByGenre(id))
        return response.results.map { MovieDetails(dto: $0) }
    }
    
}
