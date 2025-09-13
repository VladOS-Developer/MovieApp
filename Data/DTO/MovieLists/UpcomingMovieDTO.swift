//
//  UpcomingMovieDTO.swift
//  MovieApp
//
//  Created by VladOS on 04.09.2025.
//

import Foundation

struct UpcomingResponseDTO: Decodable {
    let results: [UpcomingMovieDTO]
}

struct UpcomingMovieDTO: Decodable {
    let id: Int
    let title: String
    let originalTitle: String?
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let genreIDs: [Int]
    let voteAverage: Double?
   
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
        case voteAverage = "vote_average"
    }
}
