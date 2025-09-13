//
//  MovieRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 05.09.2025.
//

import Foundation

protocol MovieRepositoryProtocol: AnyObject {
    func fetchTopMovies() -> [Movie]
    func fetchUpcomingMovies() -> [Movie]
    func fetchMovies(byGenre id: Int) -> [Movie]
}
