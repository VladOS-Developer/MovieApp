//
//  ActorDetailsDTO.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct ActorDetailsDTO: Decodable {
    let id: Int
    let name: String
    let profilePath: String?
    let birthday: String?
    let placeOfBirth: String?
    let biography: String?

    enum CodingKeys: String, CodingKey {
        case id, name, biography, birthday
        case profilePath = "profile_path"
        case placeOfBirth = "place_of_birth"
    }
}
