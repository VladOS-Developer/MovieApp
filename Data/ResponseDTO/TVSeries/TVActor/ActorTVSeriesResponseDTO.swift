//
//  ActorTVSeriesResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import Foundation

struct ActorTVSeriesResponseDTO: Decodable {
    let cast: [ActorTVSeriesDTO]
    let crew: [ActorTVSeriesDTO]?
}
