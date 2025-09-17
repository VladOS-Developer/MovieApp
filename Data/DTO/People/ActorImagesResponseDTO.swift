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

struct ActorImageDTO: Decodable {
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
