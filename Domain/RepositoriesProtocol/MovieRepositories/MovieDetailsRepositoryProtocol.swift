//
//  MovieDetailsRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

protocol MovieDetailsRepositoryProtocol: AnyObject {
    
    func fetchTopMovieDetails(page: Int) async throws -> [MovieDetails]
    
    func fetchUpcomingMovieDetails(page: Int) async throws -> [MovieDetails]
    
    func fetchMovieDetails(byGenre id: Int, page: Int) async throws -> [MovieDetails]
    
    func fetchMovieDetails(byId id: Int) async throws -> MovieDetails
}
