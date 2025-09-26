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

    static func mockActor(id: Int) -> ActorDetails {
        switch id {
        case 6193://
            return ActorDetails(
                id: 6193,
                name: "Sam Worthington",
                profilePath: "actor1",
                birthday: "1976-08-02",
                placeOfBirth: "Godalming, England",
                biography: "Sam Worthington is an Australian actor born in England in 1976, known for his major roles in films like Jake Sully in the Avatar franchise, Marcus Wright in Terminator Salvation, and Perseus in Clash of the Titans. After moving to Australia as a child, he worked as a bricklayer before earning a scholarship to the National Institute of Dramatic Art (NIDA). His international breakthrough came with Avatar (2009), launching him into numerous Hollywood blockbusters and establishing him as a significant star. He is married to Lara Worthington (née Bingle) and has three sons.",
                isLocalImage: true
            )
        case 1234://
            return ActorDetails(
                id: 1234,
                name: "Zoe Saldana",
                profilePath: "actor2",
                birthday: "1978-06-19",
                placeOfBirth: "Passaic, New Jersey, USA",
                biography: "Zoe Saldaña is an American actress of Dominican and Puerto Rican descent, born in Passaic, New Jersey, on June 19, 1978. After her father's death at age nine, she moved with her sisters to the Dominican Republic, where she began formal dance training at the ECOS Espacio de Danza Academy. She started her acting career in theater before making her film debut in Center Stage (2000). Saldaña gained recognition for her roles in Crossroads (2002) and Pirates of the Caribbean (2003), but achieved blockbuster status with lead roles in the Star Trek, Avatar, and Marvel Cinematic Universe franchises, making her one of the highest-grossing actresses in history.",
                isLocalImage: true
            )
        case 5678://
            return ActorDetails(
                id: 5678,
                name: "Sigourney Weaver",
                profilePath: "actor3",
                birthday: "1949-10-08",
                placeOfBirth: "New York City",
                biography: "Sigourney Weaver is an acclaimed American actress, born October 8, 1949, best known for her role as the strong, independent Ellen Ripley in the Alien franchise. The daughter of a TV executive and an actress, she attended Stanford and Yale, graduating from the Yale School of Drama. Weaver is a three-time Oscar nominee and the first person to win two Golden Globe acting awards in the same year for Gorillas in the Mist and Working Girl. Her career spans from the iconic Ripley to roles in films like Ghostbusters and Avatar, as well as numerous stage and voice-over performances.",
                isLocalImage: true
            )
            
        case 9012:
            return ActorDetails(
                id: 9012,
                name: "Stephen Lang",
                profilePath: "actor4",
                birthday: "1952-07-11",
                placeOfBirth: "New York City",
                biography: "Stephen Lang is an American actor, born July 11, 1952, known for his roles in films like James Cameron's Avatar and Don't Breathe, and for portraying historical figures in Gettysburg and Gods and Generals. He began his career in theater, earning a Tony Award nomination and developing and performing his play, Beyond Glory, which was also taken on a USO tour for military personnel. Lang is also recognized for his work on television series such as Crime Story and Terra Nova.",
                isLocalImage: true
            )
        case 3456:
            return ActorDetails(
                id: 3456,
                name: "Giovanni Ribisi",
                profilePath: "actor5",
                birthday: "1949-10-17",
                placeOfBirth: "Los Angeles",
                biography: "Giovanni Ribisi is an American actor known for roles in films like Saving Private Ryan, Avatar, and Ted, as well as the sitcom Friends. Born on December 17, 1974, in Los Angeles, he is the twin brother of actress Marissa Ribisi. He began his career in the mid-1980s, appearing on television shows before gaining broader recognition. ",
                isLocalImage: true
            )
        default:
            return ActorDetails(
                id: -1,
                name: "Unknown Actor",
                profilePath: nil,
                birthday: nil,
                placeOfBirth: nil,
                biography: nil,
                isLocalImage: false
            )
        }
    }
}
