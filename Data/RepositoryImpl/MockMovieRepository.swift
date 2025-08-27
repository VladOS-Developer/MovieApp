//
//  MockMovieRepository.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

final class MockMovieRepository: MovieRepositoryProtocol {
    
    static let shared = MockMovieRepository()
    private init() {}

    func fetchGenres() -> [Genre] {
        Genre.mockGenres()
    }

    func fetchTopMovies() -> [Movie] {
        Movie.mockTopMovies()
    }

    func fetchUpcomingMovies() -> [Movie] {
        Movie.mockUpcomingMovies()
    }

    func fetchMovies(byGenre id: Int) -> [Movie] {
        let all = Movie.mockTopMovies() + Movie.mockUpcomingMovies()
        return all.filter { $0.genreIDs.contains(id) }
    }
    
    func fetchMovie(id: Int) -> Movie? {
        let all = fetchTopMovies() + fetchUpcomingMovies()
        return all.first { $0.id == id }
    }
}
