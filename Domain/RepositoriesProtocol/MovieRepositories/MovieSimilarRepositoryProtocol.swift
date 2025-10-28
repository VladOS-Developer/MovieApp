//
//  MovieSimilarRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import Foundation

protocol MovieSimilarRepositoryProtocol: AnyObject {
    
    func fetchSimilarMovie(for movieId: Int) async throws -> [MovieSimilar]
}
