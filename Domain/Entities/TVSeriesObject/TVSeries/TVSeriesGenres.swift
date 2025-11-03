//
//  TVGenre.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

struct TVSeriesGenres: Hashable {
    let id: Int
    let name: String
}

extension TVSeriesGenres {
    
    init(dto: TVSeriesGenreDTO) {
        self.id = dto.id
        self.name = dto.name
    }
    
    static func mockTVGenres() -> [TVSeriesGenres] {
        return [
            TVSeriesGenres(id: 10759, name: "Action & Adventure"),
            TVSeriesGenres(id: 16, name: "Animation"),
            TVSeriesGenres(id: 35, name: "Comedy"),
            TVSeriesGenres(id: 80, name: "Crime"),
            TVSeriesGenres(id: 99, name: "Documentary"),
            TVSeriesGenres(id: 18, name: "Drama"),
            TVSeriesGenres(id: 10751, name: "Family"),
            TVSeriesGenres(id: 10762, name: "Kids"),
            TVSeriesGenres(id: 9648, name: "Mystery"),
            TVSeriesGenres(id: 10763, name: "News"),
            TVSeriesGenres(id: 10764, name: "Reality"),
            TVSeriesGenres(id: 10765, name: "Sci-Fi & Fantasy"),
            TVSeriesGenres(id: 10766, name: "Soap"),
            TVSeriesGenres(id: 10767, name: "Talk"),
            TVSeriesGenres(id: 10768, name: "War & Politics"),
            TVSeriesGenres(id: 37, name: "Western")
        ]
    }
}
