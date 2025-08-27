//
//  Trailer.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import Foundation

struct Trailer: Hashable {
    let id: String
    let key: String   // для запуска YouTube-видео
    let name: String  // название трейлера
    let site: String  // обычно "YouTube"
    let type: String  // Trailer / Teaser / Clip
}

extension Trailer {
    init(dto: TrailerDTO) {
        self.id = dto.id
        self.key = dto.key
        self.name = dto.name
        self.site = dto.site
        self.type = dto.type
    }
}

extension Trailer {
    static func mockTrailer() -> [Trailer] {
        return [
            Trailer(id: "1", key: "", name: "Official Teaser Trailer", site: "YouTube", type: "Trailer"),
            Trailer(id: "2", key: "", name: "New Trailer", site: "YouTube", type: "New Trailer"),
        ]
    }
}
