//
//  TVGenresRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

protocol TVGenresRepositoryProtocol: AnyObject {
    
    func fetchTVGenres() async throws -> [TVGenres]
}
