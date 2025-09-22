//
//  MovieVideosResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import Foundation

struct MovieVideosResponseDTO: Decodable {
    let id: Int
    let results: [MovieVideoDTO]
}
