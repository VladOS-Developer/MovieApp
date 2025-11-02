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
    
    static func fetchEpisodes(for tvId: Int, seasonNumber: Int) -> [TVEpisode] {
        if tvId == 1 && seasonNumber == 1 {
            return [
                TVEpisode(
                    id: 1001,
                    name: "Winter Is Coming",
                    episodeNumber: 1,
                    airDate: "2011-04-17",
                    runtime: 62,
                    overview: "Ned Stark learns disturbing news.",
                    stillPath: "/got_ep1.jpg",
                    videos: [
                        TVEpisodeVideo(id: "v1", key: "GoT_EP1_Trailer", name: "Trailer", site: "YouTube", type: "Trailer")
                    ]
                ),
                TVEpisode(
                    id: 1002,
                    name: "The Kingsroad",
                    episodeNumber: 2,
                    airDate: "2011-04-24",
                    runtime: 56,
                    overview: "The Starks head south.",
                    stillPath: "/got_ep2.jpg",
                    videos: [
                        TVEpisodeVideo(id: "v2", key: "GoT_EP2_Trailer", name: "Trailer", site: "YouTube", type: "Trailer")
                    ]
                )
            ]
        } else if tvId == 2 && seasonNumber == 1 {
            return [
                TVEpisode(
                    id: 2001,
                    name: "Pilot",
                    episodeNumber: 1,
                    airDate: "2008-01-20",
                    runtime: 58,
                    overview: "A chemistry teacher turns to crime.",
                    stillPath: "/bb_ep1.jpg",
                    videos: [
                        TVEpisodeVideo(id: "v3", key: "BB_EP1_Trailer", name: "Trailer", site: "YouTube", type: "Trailer")
                    ]
                ),
                TVEpisode(
                    id: 2002,
                    name: "Cat’s in the Bag...",
                    episodeNumber: 2,
                    airDate: "2008-01-27",
                    runtime: 48,
                    overview: "Walter and Jesse face consequences.",
                    stillPath: "/bb_ep2.jpg",
                    videos: [
                        TVEpisodeVideo(id: "v4", key: "BB_EP2_Trailer", name: "Trailer", site: "YouTube", type: "Trailer")
                    ]
                )
            ]
        }
        return []
    }
}
