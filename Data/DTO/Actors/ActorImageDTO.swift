//
//  ActorImageDTO.swift
//  MovieApp
//
//  Created by VladOS on 22.09.2025.
//

import Foundation

struct ActorImageDTO: Decodable {
    let filePath: String
    let width: Int?
    let height: Int?
    let aspectRatio: Double?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case width, height
        case filePath = "file_path"
        case aspectRatio = "aspect_ratio"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
