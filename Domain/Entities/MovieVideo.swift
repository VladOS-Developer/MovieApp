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
    
    var youtubeKey: String { key }
    
}

extension MovieVideo {
    static func mockMovieVideo() -> [MovieVideo] {
        return [
            MovieVideo(id: "1", key: "d9MyW72ELq0", name: "Avatar: The Way of Water | Official Teaser", site: "YouTube", type: "Trailer"),
            MovieVideo(id: "2", key: "6ZfuNTqbHE8", name: "Avengers: Infinity War Trailer", site: "YouTube", type: "Trailer"),
            MovieVideo(id: "3", key: "EXeTwQWrcwY", name: "The Dark Knight Trailer", site: "YouTube", type: "Trailer"),
            
        ]
    }
}
