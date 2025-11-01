//
//  ActorTVSeriesDTO.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

struct TVSeriesActorDTO: Decodable {
    let id: Int
    let name: String
    let posterPath: String?
    let firstAirDate: String?
    let character: String?

    enum CodingKeys: String, CodingKey {
        case id, name, character
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
    }
}
