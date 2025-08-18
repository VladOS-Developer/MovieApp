//
//  MovieServiceProtocol.swift
//  MovieApp
//
//  Created by VladOS on 17.08.2025.
//

import Foundation

protocol MovieServiceProtocol: AnyObject {
    func fetchGenres() -> [Genre]
    func fetchTopMovies() -> [Movie]
    func fetchUpcomingMovies() -> [Movie]
    func fetchMovies(byGenre id: Int) -> [Movie]
    func fetchMovie(id: Int) -> Movie?
}
