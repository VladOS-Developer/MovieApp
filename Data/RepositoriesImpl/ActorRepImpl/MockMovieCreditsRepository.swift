//
//  MockMovieCreditsRepository.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import Foundation

final class MockMovieCreditsRepository: MovieCreditsRepositoryProtocol {
    static let shared = MockMovieCreditsRepository()
    private init() {}

    func fetchCredits(for movieId: Int) -> MovieCredits {
        let cast = [
            CastMember(id: 6193, creditId: "52fe4214c3a36847f800b579", name: "Sam Worthington", character: "Jake Sully", profilePath: "img8", isLocalImage: true),
            CastMember(id: 1234, creditId: "52fe4214c3a36847f800b580", name: "Zoe Saldana", character: "Neytiri", profilePath: "img9", isLocalImage: true),
            CastMember(id: 1234, creditId: "52fe4214c3a36847f800b580", name: "Zoe Saldana", character: "Neytiri", profilePath: "img10", isLocalImage: true),
            CastMember(id: 1234, creditId: "52fe4214c3a36847f800b580", name: "Zoe Saldana", character: "Neytiri", profilePath: "img11", isLocalImage: true)
        ]
        let crew = [
            CrewMember(id: 2710, creditId: "52fe4214c3a36847f800b999", name: "James Cameron", job: "Director", department: "Directing", profilePath: "/cameron.jpg"),
            CrewMember(id: 3456, creditId: "52fe4214c3a36847f800b998", name: "Jon Landau", job: "Producer", department: "Production", profilePath: "/landau.jpg")
        ]
        return MovieCredits(cast: cast, crew: crew)
    }
}
