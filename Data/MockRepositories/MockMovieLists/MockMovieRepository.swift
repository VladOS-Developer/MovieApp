//
//  MockMovieRepository.swift
//  MovieApp
//
//  Created by VladOS on 05.09.2025.
//

import Foundation

final class MockMovieRepository: MovieRepositoryProtocol {
    static let shared = MockMovieRepository()
    
    func fetchTopMovies() async throws -> [Movie] {
        Movie.mockTopRatedMovie()
    }
    
    func fetchUpcomingMovies() async throws -> [Movie] {
        Movie.mockUpcomingMovie()
    }
    
    func fetchMovies(byGenre id: Int, page: Int) async throws -> [Movie] {
        let all = Movie.mockTopRatedMovie() + Movie.mockUpcomingMovie()
        return all.filter { $0.genreIDs.contains(id) }
    }
    
    func searchMovies(query: String, page: Int) async throws -> [Movie] {
        let all = Movie.mockTopRatedMovie() + Movie.mockUpcomingMovie()
        let filtered = all.filter { $0.title.lowercased().contains(query.lowercased()) }
        return filtered
    }
}

// MARK:  Dispatch group (iOS 13-14)
//    func fetchTopMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        completion(.success(Movie.mockTopRatedMovie()))
//    }
//
//    func fetchUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        completion(.success(Movie.mockUpcomingMovie()))
//    }
//
//    func fetchMovies(byGenre id: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
//        let all = Movie.mockTopRatedMovie() + Movie.mockUpcomingMovie()
//        completion(.success(all.filter { $0.genreIDs.contains(id) }))
//    }

