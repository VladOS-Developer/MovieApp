//
//  TVEpisodeVideosResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVEpisodeVideosResponseDTO: Decodable {
    let id: Int
    let results: [TVEpisodeVideoDTO]
}
