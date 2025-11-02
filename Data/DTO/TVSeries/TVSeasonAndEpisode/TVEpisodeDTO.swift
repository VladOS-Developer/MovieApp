//
//  TVEpisodeDTO.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVEpisodeDTO: Decodable {
    let id: Int
    let name: String
    let episodeNumber: Int
    let airDate: String?
    let runtime: Int?
    let overview: String?
    let stillPath: String?
}
