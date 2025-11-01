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
}
