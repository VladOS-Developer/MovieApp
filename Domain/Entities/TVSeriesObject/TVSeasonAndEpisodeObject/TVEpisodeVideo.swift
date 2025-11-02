//
//  TVEpisodeVideo.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVEpisodeVideo: Hashable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
}

extension TVEpisodeVideo {
    init(dto: TVEpisodeVideoDTO) {
        self.id = dto.id
        self.key = dto.key
        self.name = dto.name
        self.site = dto.site
        self.type = dto.type
    }
    
    static func fetchEpisodeVideos(for tvId: Int, seasonNumber: Int, episodeNumber: Int) -> [TVEpisodeVideo] {
        return [
            TVEpisodeVideo(id: "mock1", key: "mock_video_key", name: "Mock Trailer", site: "YouTube", type: "Trailer")
        ]
    }
}
