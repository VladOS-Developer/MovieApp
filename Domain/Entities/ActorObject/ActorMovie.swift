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
            ActorMovie(id: 1, title: "Avatar", posterPath: "film1", releaseDate: "2010-07-16", character: "Cobb", isLocalImage: true),
            ActorMovie(id: 2, title: "Avengers", posterPath: "film2", releaseDate: "1997-12-19", character: "Jack Dawson", isLocalImage: true),
            ActorMovie(id: 3, title: "The Dark Knight", posterPath: "film3", releaseDate: "2015-12-25", character: "Hugh Glass", isLocalImage: true),
            ActorMovie(id: 4, title: "Matrix: Reloaded", posterPath: "film4", releaseDate: "2015-12-25", character: "Hugh Glass", isLocalImage: true),
            ActorMovie(id: 5, title: "Dune: Part Two", posterPath: "film5", releaseDate: "2015-12-25", character: "Hugh Glass", isLocalImage: true)
        ]
    }
}
