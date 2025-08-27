//
//  MovieRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

protocol MovieRepositoryProtocol: AnyObject {
    func fetchTopMovies() -> [Movie]
    func fetchUpcomingMovies() -> [Movie]
    func fetchMovies(byGenre id: Int) -> [Movie]
    func fetchMovie(id: Int) -> Movie?
}
