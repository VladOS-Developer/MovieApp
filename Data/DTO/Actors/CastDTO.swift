//
//  CastDTO.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct CastDTO: Decodable {
    let id: Int
    let creditId: String
    let name: String
    let character: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditId = "credit_id"
        case name
        case character
        case profilePath = "profile_path"
    }
}
