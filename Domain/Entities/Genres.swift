//
//  Genres.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct Genres: Hashable {
    let id: Int
    let name: String
}

extension Genres {
    init(dto: GenreDTO) {
        self.id = dto.id
        self.name = dto.name
    }
}

extension Genres {
    static func mockGenres() -> [Genres] {
        return [
            Genres(id: 28, name: "Action"),
            Genres(id: 12, name: "Adventure"),
            Genres(id: 16, name: "Animation"),
            Genres(id: 35, name: "Comedy"),
            Genres(id: 80, name: "Crime"),
            Genres(id: 99, name: "Documentary"),
            Genres(id: 18, name: "Drama"),
            Genres(id: 10751, name: "Family"),
            Genres(id: 14, name: "Fantasy"),
            Genres(id: 36, name: "History"),
            Genres(id: 27, name: "Horror"),
            Genres(id: 10402, name: "Music"),
            Genres(id: 9648, name: "Mystery"),
            Genres(id: 10749, name: "Romance"),
            Genres(id: 878, name: "Science Fiction"),
            Genres(id: 10770, name: "TV Movie"),
            Genres(id: 53, name: "Thriller"),
            Genres(id: 10752, name: "War"),
            Genres(id: 37, name: "Western")
        ]
    }
}
