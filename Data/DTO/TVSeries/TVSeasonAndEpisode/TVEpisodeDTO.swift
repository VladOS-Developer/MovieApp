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
    let overview: String?
    let airDate: String?
    let episodeNumber: Int
    let seasonNumber: Int?
    let runtime: Int?
    let stillPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview, runtime
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case seasonNumber = "season_number"
        case stillPath = "still_path"
    }
}
