//
//  TopRatedResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import Foundation

struct TopRatedResponseDTO: Decodable {
    let results: [TopRatedMovieDTO]
}
