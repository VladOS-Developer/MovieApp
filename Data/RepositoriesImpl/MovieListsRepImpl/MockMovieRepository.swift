//
//  MockMovieRepository.swift
//  MovieApp
//
//  Created by VladOS on 05.09.2025.
//

import Foundation

final class MockMovieRepository: MovieRepositoryProtocol {
    static let shared = MockMovieRepository()
    
    func fetchTopMovies() -> [Movie] {
        Movie.mockTopRatedMovie()
    }
    
    func fetchUpcomingMovies() -> [Movie] {
        Movie.mockUpcomingMovie()
    }
    
    func fetchMovies(byGenre id: Int) -> [Movie] {
        let all = Movie.mockTopRatedMovie() + Movie.mockUpcomingMovie()
        return all.filter { $0.genreIDs.contains(id) }
    }
}
