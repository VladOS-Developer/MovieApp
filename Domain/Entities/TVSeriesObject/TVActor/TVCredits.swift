//
//  TVCredits.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import Foundation

struct TVCredits {
    let cast: [CastMember]
    let crew: [CrewMember]
}

extension TVCredits {
    
    init(dto: TVCreditsResponseDTO) {
        self.cast = dto.cast.map { CastMember(dto: $0) }
        self.crew = dto.crew.map { CrewMember(dto: $0) }
    }
    
    static func mockTVCredits() -> TVCredits {
        return TVCredits(
            cast: CastMember.mockCast(),
            crew: CrewMember.mockCrew()
        )
    }
}
