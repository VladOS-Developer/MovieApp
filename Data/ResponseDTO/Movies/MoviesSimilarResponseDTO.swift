//
//  MoviesSimilarResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import Foundation

struct MoviesSimilarResponseDTO: Decodable {
    let results: [MovieSimilarDTO]
}
