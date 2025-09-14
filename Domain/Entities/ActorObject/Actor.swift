//
//  Actor.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct Actor: Hashable {
    let id: Int
    let name: String
    let profilePath: String?
    let birthday: String?
    let placeOfBirth: String?
    let biography: String?
}

extension Actor {
    init(dto: ActorDetailsDTO) {
        self.id = dto.id
        self.name = dto.name
        self.profilePath = dto.profilePath
        self.birthday = dto.birthday
        self.placeOfBirth = dto.placeOfBirth
        self.biography = dto.biography
    }
    
    static func mockActor() -> Actor {
        return Actor(id: 1,name: "Leonardo DiCaprio",profilePath: "leonardo.jpg",birthday: "1974-11-11",
                     placeOfBirth: "Los Angeles, California, USA",
                     biography: "American actor and producer known for Titanic, Inception, The Revenant..."
        )
    }
}
