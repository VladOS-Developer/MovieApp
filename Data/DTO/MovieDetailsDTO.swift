//
//  MovieDetailsDTO.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct ProductionCountryDTO: Decodable {
    let iso3166_1: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct MovieDetailsDTO: Decodable {
    let id: Int
    let title: String
    let originalTitle: String?
    let posterPath: String?
    let backdropPath: String?
    let runtime: Int?
    let releaseDate: String?
    let genreIDs: [Int]
    let overview: String?
    let productionCountries: [ProductionCountryDTO]?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
        case productionCountries = "production_countries"
        case voteAverage = "vote_average"
    }
}


