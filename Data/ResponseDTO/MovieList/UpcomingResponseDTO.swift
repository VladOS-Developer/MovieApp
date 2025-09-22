//
//  UpcomingResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 20.09.2025.
//

import Foundation

struct UpcomingResponseDTO: Decodable {
    let results: [UpcomingMovieDTO]
}
