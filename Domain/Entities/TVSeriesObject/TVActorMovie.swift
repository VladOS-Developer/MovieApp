//
//  TVActorMovie.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

struct TVActorMovie: Hashable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let character: String?
    let isLocalImage: Bool
}


extension TVActorMovie {
    
    init(tvDTO: TVSeriesActorDTO) {
        self.id = tvDTO.id
        self.title = tvDTO.name
        self.posterPath = tvDTO.posterPath
        self.releaseDate = tvDTO.firstAirDate
        self.character = tvDTO.character
        self.isLocalImage = false
    }
    
    static func mockActorSeries() -> [TVActorMovie] {
        return [
            TVActorMovie(id: 1, title: "Game of Thrones", posterPath: "siries1", releaseDate: "2010-07-16", character: "Cobb", isLocalImage: true),
            TVActorMovie(id: 2, title: "Breaking Bad", posterPath: "siries2", releaseDate: "1997-12-19", character: "Jack Dawson", isLocalImage: true)
        ]
    }
}
