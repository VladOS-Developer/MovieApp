//
//  TVSeriesDetailsDTO.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

struct TVSeriesProductionCountryDTO: Decodable {
    let iso3166_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct TVSeriesDetailsDTO: Decodable {
    let id: Int
    let name: String
    let originalName: String?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    let lastAirDate: String?
    let numberOfSeasons: Int?
    let numberOfEpisodes: Int?
    let episodeRunTime: [Int]?
    let overview: String?
    let genreIDs: [Int]?
    let genres: [TVSeriesGenreDTO]?
    let originCountry: [String]?
    let productionCountries: [TVSeriesProductionCountryDTO]?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, overview, genres
        case originalName = "original_name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        case episodeRunTime = "episode_run_time"
        case genreIDs = "genre_ids"
        case originCountry = "origin_country"
        case productionCountries = "production_countries"
        case voteAverage = "vote_average"
    }
}
