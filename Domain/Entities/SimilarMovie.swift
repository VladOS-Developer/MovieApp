//
//  SimilarMovie.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import Foundation

struct SimilarMovie: Hashable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
}

extension SimilarMovie {
    init(dto: SimilarMovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.posterPath = dto.posterPath
        self.releaseDate = dto.releaseDate
    }
}

extension SimilarMovie {
    static func mockSimilarMovies() -> [SimilarMovie] {
        return [
            SimilarMovie(id: 101, title: "Inception", posterPath: "img1", releaseDate: "2010-07-16"),
            SimilarMovie(id: 102, title: "Interstellar", posterPath: "img2", releaseDate: "2014-11-07"),
            SimilarMovie(id: 103, title: "Tenet", posterPath: "img3", releaseDate: "2020-08-26"),
        ]
    }
}
