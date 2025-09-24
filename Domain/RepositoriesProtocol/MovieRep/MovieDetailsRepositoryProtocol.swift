//
//  MovieDetailsRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

    protocol MovieDetailsRepositoryProtocol: AnyObject {
        
        func fetchTopMovieDetails() async throws -> [MovieDetails]
        func fetchUpcomingMovieDetails() async throws -> [MovieDetails]
        func fetchMovieDetails(byGenre id: Int) async throws -> [MovieDetails]
    }
