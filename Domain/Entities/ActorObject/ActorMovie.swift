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
}

extension ActorMovie {
    init(dto: ActorMovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.posterPath = dto.posterPath
        self.releaseDate = dto.releaseDate
        self.character = dto.character
    }

    static func mockMovies() -> [ActorMovie] {
        return [
            ActorMovie(id: 10, title: "Inception", posterPath: "inception.jpg", releaseDate: "2010-07-16", character: "Cobb"),
            ActorMovie(id: 11, title: "Titanic", posterPath: "titanic.jpg", releaseDate: "1997-12-19", character: "Jack Dawson"),
            ActorMovie(id: 12, title: "The Revenant", posterPath: "revenant.jpg", releaseDate: "2015-12-25", character: "Hugh Glass")
        ]
    }
}
