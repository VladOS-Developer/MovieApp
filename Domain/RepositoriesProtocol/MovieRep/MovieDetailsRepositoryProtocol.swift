//
//  MovieDetailsRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

protocol MovieDetailsRepositoryProtocol: AnyObject {
    
    func fetchTopMovieDetails() -> [MovieDetails]
    func fetchUpcomingMovieDetails() -> [MovieDetails]
    func fetchMovieDetails(byGenre id: Int) -> [MovieDetails]
}
