//
//  MovieRepository.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTopMovies() async throws -> [Movie] {
        let response: TopRatedResponseDTO = try await networkService.request(.topRatedMovies)
        return response.results.map { Movie(dto: $0) }
    }
    
    func fetchUpcomingMovies() async throws -> [Movie] {
        let response: UpcomingResponseDTO = try await networkService.request(.upcomingMovies)
        return response.results.map { Movie(dto: $0) }
    }
    
    func fetchMovies(byGenre id: Int) async throws -> [Movie] {
        let response: TopRatedResponseDTO = try await networkService.request(.moviesByGenre(id))
        return response.results.map { Movie(dto: $0) }
    }
}
