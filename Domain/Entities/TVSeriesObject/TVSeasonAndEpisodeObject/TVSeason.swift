//
//  TVSeason.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVSeason: Hashable {
    let id: Int
    let name: String
    let seasonNumber: Int
    let airDate: String?
    let episodeCount: Int
    let posterPath: String?
    let overview: String?
}

extension TVSeason {
    init(dto: TVSeasonDTO) {
        self.id = dto.id
        self.name = dto.name
        self.seasonNumber = dto.seasonNumber
        self.airDate = dto.airDate
        self.episodeCount = dto.episodeCount
        self.posterPath = dto.posterPath
        self.overview = dto.overview
    }
    
    static func fetchSeasons(for tvId: Int) -> [TVSeason] {
        switch tvId {
        case 1:
            return [
                TVSeason(id: 101, name: "Season 1", seasonNumber: 1, airDate: "2011-04-17", episodeCount: 10, posterPath: "/got_s1.jpg", overview: "The beginning of the epic saga.")
            ]
        case 2:
            return [
                TVSeason(id: 201, name: "Season 1", seasonNumber: 1, airDate: "2008-01-20", episodeCount: 7, posterPath: "/bb_s1.jpg", overview: "Walter White starts cooking.")
            ]
        default:
            return []
        }
    }
}
