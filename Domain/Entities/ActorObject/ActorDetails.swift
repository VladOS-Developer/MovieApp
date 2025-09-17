//
//  ActorDetails.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct ActorDetails: Hashable {
    let id: Int
    let name: String
    let profilePath: String?
    let birthday: String?
    let placeOfBirth: String?
    let biography: String?
    
    let isLocalImage: Bool
}

extension ActorDetails {
    init(dto: ActorDetailsDTO) {
        self.id = dto.id
        self.name = dto.name
        self.profilePath = dto.profilePath
        self.birthday = dto.birthday
        self.placeOfBirth = dto.placeOfBirth
        self.biography = dto.biography
        
        self.isLocalImage = false
    }
    
//    static func mockActor(id: Int) -> ActorDetails {
//        
//        return ActorDetails(id: 1,name: "Leonardo DiCaprio",profilePath: "img1",birthday: "1974-11-11",placeOfBirth: "Los Angeles, California, USA",
//                            biography: "American actor and producer known for Titanic, Inception, The Revenant...", isLocalImage: true)
//    }
//    
    static func mockActor(id: Int) -> ActorDetails {
            switch id {
            case 6193:
                return ActorDetails(
                    id: 6193,
                    name: "Sam Worthington",
                    profilePath: "img1",
                    birthday: "1976-08-02",
                    placeOfBirth: "Godalming, England",
                    biography: "Sam Worthington is an English-born Australian actor...",
                    isLocalImage: true
                )
            case 1234:
                return ActorDetails(
                    id: 1234,
                    name: "Zoe Saldana",
                    profilePath: "img2",
                    birthday: "1978-06-19",
                    placeOfBirth: "Passaic, New Jersey, USA",
                    biography: "Zoe Saldana is an American actress known for Avatar, Guardians of the Galaxy...",
                    isLocalImage: true
                )
            default:
                return ActorDetails(
                    id: 1,
                    name: "Leonardo DiCaprio",
                    profilePath: "img3",
                    birthday: "1974-11-11",
                    placeOfBirth: "Los Angeles, California, USA",
                    biography: "American actor and producer known for Titanic, Inception, The Revenant...",
                    isLocalImage: true
                )
            }
        }
}
