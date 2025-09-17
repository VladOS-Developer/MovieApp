//
//  CastMember.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct CastMember: Hashable {
    let id: Int
    let creditId: String
    let name: String
    let character: String?
    let profilePath: String?
    
    let isLocalImage: Bool
}

extension CastMember {
    init(dto: CastDTO) {
        self.id = dto.id
        self.creditId = dto.creditId
        self.name = dto.name
        self.character = dto.character
        self.profilePath = dto.profilePath
        
        self.isLocalImage = false
    }
}

extension CastMember {
    static func mockCast() -> [CastMember] {
        return [
            CastMember(id: 6193,creditId: "52fe4214c3a36847f800b579",name: "Sam Worthington", character: "Jake Sully",profilePath: "img1", isLocalImage: true),
            CastMember(id: 1234,creditId: "52fe4214c3a36847f800b580",name: "Zoe Saldana", character: "Neytiri",profilePath: "img2", isLocalImage: true),
            CastMember(id: 5678,creditId: "52fe4214c3a36847f800b581",name: "Sigourney Weaver",character: "Dr. Grace Augustine",profilePath: "img3", isLocalImage: true),
            CastMember(id: 9012,creditId: "52fe4214c3a36847f800b582",name: "Stephen Lang",character: "Colonel Miles Quaritch",profilePath: "img4", isLocalImage: true),
            CastMember(id: 3456,creditId: "52fe4214c3a36847f800b583",name: "Giovanni Ribisi",character: "Parker Selfridge",profilePath: "img5", isLocalImage: true)
        ]
    }
}
