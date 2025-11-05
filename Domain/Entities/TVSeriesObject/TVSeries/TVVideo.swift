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
        case 1:
            return [
                TVVideo(id: "t1", key: "gkTb9GP9lVI", name: "Breaking Bad Trailer", site: "YouTube", type: "Trailer")
            ]
        case 2:
            return [
                TVVideo(id: "t2", key: "9GgxinPwAGc", name: "Stranger Things S1 Trailer", site: "YouTube", type: "Trailer")
            ]
        default:
            return []
        }
    }
    
    static func mockTVTrendingVideos() -> [TVVideo] {
            return [
                TVVideo(id: "1", key: "X2m-08cOAbc", name: "Breaking Bad – Season 5 Trailer", site: "YouTube", type: "Trailer"),
                TVVideo(id: "2", key: "rBxcF-r9Ibs", name: "Stranger Things – Official Trailer", site: "YouTube", type: "Trailer"),
                TVVideo(id: "3", key: "gcTkNV5Vg1E", name: "The Witcher – Teaser", site: "YouTube", type: "Teaser"),
                TVVideo(id: "4", key: "qJ2tW6Wlfds", name: "Game of Thrones – Season 8 Trailer", site: "YouTube", type: "Trailer")
            ]
        }
}
