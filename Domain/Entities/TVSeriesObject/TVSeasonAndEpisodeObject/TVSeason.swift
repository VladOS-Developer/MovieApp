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
    let episodeCount: Int
    let posterPath: String?
}

extension TVSeason {
    init(dto: TVSeasonDTO) {
        self.id = dto.id
        self.name = dto.name
        self.seasonNumber = dto.seasonNumber ?? 0
        self.episodeCount = dto.episodeCount ?? 0
        self.posterPath = dto.posterPath
    }
    
    static func mockSeasons(for tvId: Int) -> [TVSeason] {
        return [
            TVSeason(id: tvId * 10 + 1, name: "Season 1", seasonNumber: 1, episodeCount: 2, posterPath: "/mock_s1.jpg"),
            TVSeason(id: tvId * 10 + 2, name: "Season 2", seasonNumber: 2, episodeCount: 2, posterPath: "/mock_s2.jpg"),
            TVSeason(id: tvId * 10 + 3, name: "Season 3", seasonNumber: 3, episodeCount: 2, posterPath: "/mock_s3.jpg")
        ]
    }
}
