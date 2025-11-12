//
//  TVEpisode.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVEpisode: Hashable {
    let id: Int
    let name: String
    let episodeNumber: Int
    let airDate: String?
    let runtime: Int?
    let overview: String?
    let stillPath: String?
    let videos: [TVEpisodeVideo]
}

extension TVEpisode {
    
    init(dto: TVEpisodeDTO, videos: [TVEpisodeVideo] = []) {
        self.id = dto.id
        self.name = dto.name
        self.episodeNumber = dto.episodeNumber
        self.airDate = dto.airDate
        self.runtime = dto.runtime
        self.overview = dto.overview
        self.stillPath = dto.stillPath
        self.videos = videos
    }
    
    static func mockEpisodes(for tvId: Int, seasonNumber: Int) -> [TVEpisode] {
        return [
            TVEpisode(
                id: tvId * 100 + seasonNumber * 10 + 1,
                name: "Episode 1",
                episodeNumber: 1,
                airDate: "2025-01-01",
                runtime: 50,
                overview: "Overview of episode 1",
                stillPath: "/mock_ep1.jpg",
                videos: [TVEpisodeVideo(id: "v1", key: "mock_key1", name: "Trailer 1", site: "YouTube", type: "Trailer")]
            ),
            TVEpisode(
                id: tvId * 100 + seasonNumber * 10 + 2,
                name: "Episode 2",
                episodeNumber: 2,
                airDate: "2025-01-08",
                runtime: 52,
                overview: "Overview of episode 2",
                stillPath: "/mock_ep2.jpg",
                videos: [TVEpisodeVideo(id: "v2", key: "mock_key2", name: "Trailer 2", site: "YouTube", type: "Trailer")]
            )
        ]
    }
}
