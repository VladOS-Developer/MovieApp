//
//  ActorMoviesResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct ActorMoviesResponseDTO: Decodable {
    let cast: [ActorMovieDTO]
}

struct ActorMovieDTO: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let character: String?

    enum CodingKeys: String, CodingKey {
        case id, title, character
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
