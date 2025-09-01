//
//  MovieSimilar.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import Foundation

struct MovieSimilar: Hashable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
}

extension MovieSimilar {
    init(dto: MovieSimilarDTO) {
        self.id = dto.id
        self.title = dto.title
        self.posterPath = dto.posterPath
        self.releaseDate = dto.releaseDate
    }
}

extension MovieSimilar {
    static func mockSimilarMovies() -> [MovieSimilar] {
        return [
            MovieSimilar(id: 101, title: "Inception", posterPath: "img9", releaseDate: "2010-07-16"),
            MovieSimilar(id: 102, title: "Interstellar", posterPath: "img10", releaseDate: "2014-11-07"),
            MovieSimilar(id: 103, title: "Tenet", posterPath: "img1", releaseDate: "2020-08-26"),
            MovieSimilar(id: 104, title: "Tenet", posterPath: "img4", releaseDate: "2020-08-26"),
            MovieSimilar(id: 105, title: "Tenet", posterPath: "img6", releaseDate: "2020-08-26"),
        ]
    }
}
