//
//  TVSimilarRepositoryProtocol.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

protocol TVSimilarRepositoryProtocol: AnyObject {
    
    func fetchSimilarTVShows(for tvId: Int) async throws -> [TVSimilar]
}
