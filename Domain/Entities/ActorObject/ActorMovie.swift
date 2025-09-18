//
//  ActorMovie.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct ActorMovie: Hashable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let character: String?
    
    let isLocalImage: Bool
}

extension ActorMovie {
    init(dto: ActorMovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.posterPath = dto.posterPath
        self.releaseDate = dto.releaseDate
        self.character = dto.character
        
        self.isLocalImage = false
    }

    static func mockActorMovies() -> [ActorMovie] {
        return [
            ActorMovie(id: 10, title: "Inception", posterPath: "img1", releaseDate: "2010-07-16", character: "Cobb", isLocalImage: true),
            ActorMovie(id: 11, title: "Titanic", posterPath: "img2", releaseDate: "1997-12-19", character: "Jack Dawson", isLocalImage: true),
            ActorMovie(id: 12, title: "The Revenant", posterPath: "img3", releaseDate: "2015-12-25", character: "Hugh Glass", isLocalImage: true),
            ActorMovie(id: 13, title: "The Revenant", posterPath: "img4", releaseDate: "2015-12-25", character: "Hugh Glass", isLocalImage: true),
            ActorMovie(id: 13, title: "The Revenant", posterPath: "img5", releaseDate: "2015-12-25", character: "Hugh Glass", isLocalImage: true)
        ]
    }
}
