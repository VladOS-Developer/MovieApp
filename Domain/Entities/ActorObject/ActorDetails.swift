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
                biography: "Sam Worthington is an Australian actor born in England in 1976, known for his major roles in films like Jake Sully in the Avatar franchise, Marcus Wright in Terminator Salvation, and Perseus in Clash of the Titans. After moving to Australia as a child, he worked as a bricklayer before earning a scholarship to the National Institute of Dramatic Art (NIDA). His international breakthrough came with Avatar (2009), launching him into numerous Hollywood blockbusters and establishing him as a significant star. He is married to Lara Worthington (née Bingle) and has three sons.",
                isLocalImage: true
            )
        case 1234:
            return ActorDetails(
                id: 1234,
                name: "Zoe Saldana",
                profilePath: "img2",
                birthday: "1978-06-19",
                placeOfBirth: "Passaic, New Jersey, USA",
                biography: "Zoe Saldaña is an American actress of Dominican and Puerto Rican descent, born in Passaic, New Jersey, on June 19, 1978. After her father's death at age nine, she moved with her sisters to the Dominican Republic, where she began formal dance training at the ECOS Espacio de Danza Academy. She started her acting career in theater before making her film debut in Center Stage (2000). Saldaña gained recognition for her roles in Crossroads (2002) and Pirates of the Caribbean (2003), but achieved blockbuster status with lead roles in the Star Trek, Avatar, and Marvel Cinematic Universe franchises, making her one of the highest-grossing actresses in history.",
                isLocalImage: true
            )
        default:
            return ActorDetails(
                id: 1,
                name: "Leonardo DiCaprio",
                profilePath: "img3",
                birthday: "1974-11-11",
                placeOfBirth: "Los Angeles, California, USA",
                biography: "Leonardo DiCaprio is a prominent American actor and producer born on November 11, 1974, in Los Angeles, California. He gained fame in the 1990s with starring roles in films like What's Eating Gilbert Grape and Titanic and has since become known for critically acclaimed performances in movies such as The Revenant, for which he won an Academy Award, and collaborations with director Martin Scorsese. DiCaprio is also a committed environmental activist who uses his foundation to promote conservation efforts. ",
                isLocalImage: true
            )
        }
    }
}
