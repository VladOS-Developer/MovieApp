//
//  GenreRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

protocol GenreRepositoryProtocol: AnyObject {
        
    func fetchGenres() async throws -> [Genres]
}
