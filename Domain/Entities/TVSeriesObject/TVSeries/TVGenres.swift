//
//  TVGenre.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

struct TVGenres: Hashable {
    let id: Int
    let name: String
}

extension TVGenres {
    
    init(dto: TVSeriesGenreDTO) {
        self.id = dto.id
        self.name = dto.name
    }
    
    static func mockTVGenres() -> [TVGenres] {
        return [
            TVGenres(id: 10759, name: "Action & Adventure"),
            TVGenres(id: 16, name: "Animation"),
            TVGenres(id: 35, name: "Comedy"),
            TVGenres(id: 80, name: "Crime"),
            TVGenres(id: 99, name: "Documentary"),
            TVGenres(id: 18, name: "Drama"),
            TVGenres(id: 10751, name: "Family"),
            TVGenres(id: 10762, name: "Kids"),
            TVGenres(id: 9648, name: "Mystery"),
            TVGenres(id: 10763, name: "News"),
            TVGenres(id: 10764, name: "Reality"),
            TVGenres(id: 10765, name: "Sci-Fi & Fantasy"),
            TVGenres(id: 10766, name: "Soap"),
            TVGenres(id: 10767, name: "Talk"),
            TVGenres(id: 10768, name: "War & Politics"),
            TVGenres(id: 37, name: "Western")
        ]
    }
}
