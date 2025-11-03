//
//  ActorMovieDTO.swift
//  MovieApp
//
//  Created by VladOS on 22.09.2025.
//

import Foundation

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
