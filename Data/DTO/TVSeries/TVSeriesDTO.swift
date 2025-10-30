//
//  TVSeriesDTO.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

struct TVSeriesDTO: Decodable {
    let id: Int
    let name: String
    let originalName: String?
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let firstAirDate: String?
    let genreIDs: [Int]
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case originalName = "original_name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
    }
}
