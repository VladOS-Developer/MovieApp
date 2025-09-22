//
//  MovieVideoRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

protocol MovieVideoRepositoryProtocol: AnyObject {
    
    func fetchMovieVideo(for movieId: Int) async throws -> [MovieVideo]
}
