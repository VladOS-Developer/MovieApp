//
//  TVCreditsResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import Foundation

struct TVCreditsResponseDTO: Decodable {
    let id: Int
    let cast: [CastDTO]
    let crew: [CrewDTO]
}
