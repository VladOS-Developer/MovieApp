//
//  SimilarMovieDTO.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import Foundation

struct SimilarMoviesResponseDTO: Decodable {
    let results: [SimilarMovieDTO]
}

struct SimilarMovieDTO: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
