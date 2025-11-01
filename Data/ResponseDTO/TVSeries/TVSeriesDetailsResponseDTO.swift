//
//  TVSeriesDetailsResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

struct TVSeriesDetailsResponseDTO: Decodable {
    let page: Int
    let results: [TVSeriesDetailsDTO]
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
