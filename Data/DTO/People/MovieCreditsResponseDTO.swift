//
//  MovieCreditsResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct MovieCreditsResponseDTO: Decodable {
    let id: Int
    let cast: [CastDTO]
    let crew: [CrewDTO]
}
