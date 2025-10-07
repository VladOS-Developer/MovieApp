//
//  MockMovieDetailsRepository.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

final class MockMovieDetailsRepository: MovieDetailsRepositoryProtocol {
    static let shared = MockMovieDetailsRepository()
    
    func fetchTopMovieDetails(page: Int) async throws -> [MovieDetails] {
        MovieDetails.mockTopMovieDetails()
    }
    
    func fetchUpcomingMovieDetails(page: Int) async throws -> [MovieDetails] {
        MovieDetails.mockUpcomingMovieDetails()
    }
    
    func fetchMovieDetails(byGenre id: Int, page: Int) async throws -> [MovieDetails] {
        let all = MovieDetails.mockTopMovieDetails() + MovieDetails.mockUpcomingMovieDetails()
        return all.filter { $0.genreIDs.contains(id) }
    }
    
    func fetchMovieDetails(byId id: Int) async throws -> MovieDetails {
        let all = MovieDetails.mockTopMovieDetails() + MovieDetails.mockUpcomingMovieDetails()
        guard let movie = all.first(where: { $0.id == id }) else {
            throw NSError(domain: "MockMovieDetailsRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Movie not found"])
        }
        return movie
    }
    
}

