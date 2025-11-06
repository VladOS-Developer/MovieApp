//
//  TVVideo.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

struct TVVideo: Hashable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
}

extension TVVideo {
    
    init(dto: TVSeriesVideoDTO) {
        self.id = dto.id
        self.key = dto.key
        self.name = dto.name
        self.site = dto.site
        self.type = dto.type
    }
    
    var youtubeKey: String { key }
    
    static func mockTVVideos(for tvId: Int) -> [TVVideo] {
        switch tvId {
        case 1399: // Game of Thrones
            return [TVVideo(id: "1", key: "gcTkNV5Vg1E", name: "Game of Thrones – Official Trailer", site: "YouTube", type: "Trailer")]
            
        case 1396: // Breaking Bad
            return [TVVideo(id: "2", key: "HhesaQXLuRY", name: "Breaking Bad – Season 5 Trailer", site: "YouTube", type: "Trailer")]
            
        case 66732: // Stranger Things
            return [TVVideo(id: "3", key: "b9EkMc79ZSU", name: "Stranger Things – Season 1 Trailer", site: "YouTube", type: "Trailer")]
            
        case 1402: // The Walking Dead
            return [TVVideo(id: "4", key: "sfAc2U20uyg", name: "The Walking Dead – Official Trailer", site: "YouTube", type: "Trailer")]
        default:
            return []
        }
    }
    
    
    static func mockTVTrendingVideos() -> [TVVideo] {
        return [
            TVVideo(id: "1", key: "gcTkNV5Vg1E", name: "Game of Thrones – Official Trailer", site: "YouTube", type: "Trailer"),
            TVVideo(id: "2", key: "HhesaQXLuRY", name: "Breaking Bad – Season 5 Trailer", site: "YouTube", type: "Trailer"),
            TVVideo(id: "3", key: "b9EkMc79ZSU", name: "Stranger Things – Season 1 Trailer", site: "YouTube", type: "Trailer"),
            TVVideo(id: "4", key: "sfAc2U20uyg", name: "The Walking Dead – Official Trailer", site: "YouTube", type: "Trailer")
        ]
    }
    
}
