//
//  MovieSimilarDTO.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import Foundation

struct MovieSimilarDTO: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let originalTitle: String?
    let backdropPath: String?
    let genreIDs: [Int]?
    let overview: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}
