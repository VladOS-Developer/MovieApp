//
//  MockMovieDetailsRepository.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

final class MockMovieDetailsRepository: MovieDetailsRepositoryProtocol {
    
    static let shared = MockMovieDetailsRepository()
    
    func fetchTopMovieDetails() -> [MovieDetails] {
        MovieDetails.mockTopMovieDetails()
    }
    
    func fetchUpcomingMovieDetails() -> [MovieDetails] {
        MovieDetails.mockUpcomingMovieDetails()
    }
    
    func fetchMovieDetails(byGenre id: Int) -> [MovieDetails] {
        let all = MovieDetails.mockTopMovieDetails() + MovieDetails.mockUpcomingMovieDetails()
        return all.filter { $0.genreIDs.contains(id) }
    }
}
