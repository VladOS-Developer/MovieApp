//
//  MoviesListResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 24.09.2025.
//

import Foundation

struct MoviesListResponseDTO: Decodable {
    let page: Int
    let results: [MovieDetailsDTO]
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
