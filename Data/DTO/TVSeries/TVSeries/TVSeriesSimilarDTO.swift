//
//  TVSimilarDTO.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVSeriesSimilarDTO: Decodable {
    let id: Int
    let name: String
    let originalName: String?
    let posterPath: String?
    let firstAirDate: String?
    let backdropPath: String?
    let genreIDs: [Int]?
    let overview: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case originalName = "original_name"
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
    }
}
