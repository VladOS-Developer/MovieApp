//
//  ActorImagesResponseDTO.swift
//  MovieApp
//
//  Created by VladOS on 17.09.2025.
//

import Foundation

struct ActorImagesResponseDTO: Decodable {
    let id: Int
    let profiles: [ActorImageDTO]
}
