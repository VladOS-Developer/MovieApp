//
//  ActorImageDTO.swift
//  MovieApp
//
//  Created by VladOS on 22.09.2025.
//

import Foundation

struct ActorImageDTO: Decodable {
    let filePath: String

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
