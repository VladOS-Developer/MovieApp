//
//  MovieVideo.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

struct MovieVideo: Hashable {
    let id: String
    let key: String   // для запуска YouTube-видео
    let name: String  // название трейлера
    let site: String  // обычно "YouTube"
    let type: String  // Trailer / Teaser / Clip
}

extension MovieVideo {
    init(dto: MovieVideoDTO) {
        self.id = dto.id
        self.key = dto.key
        self.name = dto.name
        self.site = dto.site
        self.type = dto.type
    }
}

extension MovieVideo {
    static func mockMovieVideo() -> [MovieVideo] {
        return [
            MovieVideo(id: "", key: "img10", name: "Official Teaser Trailer", site: "YouTube", type: "Trailer"),
            MovieVideo(id: "", key: "img11", name: "New Trailer", site: "YouTube", type: "Clip"),
        ]
    }
}
