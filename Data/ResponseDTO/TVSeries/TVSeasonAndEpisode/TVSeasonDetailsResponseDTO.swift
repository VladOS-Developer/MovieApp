//
//  TVSeasonDetailsResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVSeasonDetailsResponseDTO: Decodable {
    let id: Int
    let seasonNumber: Int
    let episodes: [TVEpisodeDTO]
}
