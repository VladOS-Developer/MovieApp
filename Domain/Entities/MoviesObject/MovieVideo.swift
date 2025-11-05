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
    
    static func mockMovieVideo(for movieId: Int) -> [MovieVideo] {
        
        switch movieId {
        case 1: // Avatar
            return [
                MovieVideo(id: "1", key: "d9MyW72ELq0", name: "Avatar: The Way of Water", site: "YouTube", type: "Trailer"),
                MovieVideo(id: "2", key: "M7lc1UVf-VE", name: "Google for Developers", site: "YouTube", type: ""),
            ]
        case 2: // Avengers
            return [
                MovieVideo(id: "3", key: "6ZfuNTqbHE8", name: "Avengers: Infinity War Trailer", site: "YouTube", type: "Trailer")
            ]
        case 3: // Dark Knight
            return [
                MovieVideo(id: "4", key: "EXeTwQWrcwY", name: "The Dark Knight Trailer", site: "YouTube", type: "Trailer")
            ]
        default:
            return []
        }
    }
    
    static func mockTrendingVideos() -> [MovieVideo] {
        return [
            MovieVideo(id: "1", key: "d9MyW72ELq0", name: "Avatar: The Way of Water", site: "YouTube", type: "Trailer"),
            MovieVideo(id: "2", key: "M7lc1UVf-VE", name: "Google for Developers", site: "YouTube", type: "Clip"),
            MovieVideo(id: "3", key: "6ZfuNTqbHE8", name: "Avengers: Infinity War", site: "YouTube", type: "Trailer"),
            MovieVideo(id: "4", key: "EXeTwQWrcwY", name: "The Dark Knight", site: "YouTube", type: "Trailer"),
        ]
    }
}
