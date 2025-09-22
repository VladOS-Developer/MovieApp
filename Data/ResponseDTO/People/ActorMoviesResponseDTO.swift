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

