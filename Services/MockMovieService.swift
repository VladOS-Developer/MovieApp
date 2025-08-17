//
//  MockMovieService.swift
//  MovieApp
//
//  Created by VladOS on 17.08.2025.
//

import Foundation

final class MockMovieService: MovieServiceProtocol {
    static let shared = MockMovieService()
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
}
