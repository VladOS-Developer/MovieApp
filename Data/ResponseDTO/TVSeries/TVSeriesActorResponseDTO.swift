//
//  ActorTVSeriesResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

struct TVSeriesActorResponseDTO: Decodable {
    let cast: [TVSeriesActorDTO]
    let crew: [TVSeriesActorDTO]?
}
