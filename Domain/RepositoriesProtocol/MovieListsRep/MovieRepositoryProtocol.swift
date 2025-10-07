//
//  MovieRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 05.09.2025.
//

import Foundation

protocol MovieRepositoryProtocol: AnyObject {

    func fetchTopMovies() async throws -> [Movie]
    func fetchUpcomingMovies() async throws -> [Movie]
    func fetchMovies(byGenre id: Int, page: Int) async throws -> [Movie]
}
