//
//  MovieCredits.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

struct MovieCredits {
    let cast: [CastMember]
    let crew: [CrewMember]
}

extension MovieCredits {
    init(dto: MovieCreditsResponseDTO) {
        self.cast = dto.cast.map { CastMember(dto: $0) }
        self.crew = dto.crew.map { CrewMember(dto: $0) }
    }
}

extension MovieCredits {
    static func mockCredits() -> MovieCredits {
        return MovieCredits(
            cast: CastMember.mockCast(),
            crew: CrewMember.mockCrew()
        )
    }
}
