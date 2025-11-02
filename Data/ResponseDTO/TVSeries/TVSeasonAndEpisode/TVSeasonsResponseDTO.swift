//
//  TVSeasonsResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVSeasonsResponseDTO: Decodable {
    let id: Int
    let seasons: [TVSeasonDTO]
}
