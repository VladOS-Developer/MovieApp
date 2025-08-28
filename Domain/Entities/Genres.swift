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
            Genres(id: 12, name: "Adventure"),
            Genres(id: 16, name: "Animation"),
            Genres(id: 18, name: "Drama"),
            Genres(id: 27, name: "Horror"),
            Genres(id: 28, name: "Action"),
            Genres(id: 35, name: "Comedy"),
            Genres(id: 80, name: "Crime"),
            Genres(id: 878, name: "Sci-Fi"),
            Genres(id: 88, name: "Thriller"),
            Genres(id: 89, name: "Fantasy"),
            Genres(id: 90, name: "Mystery"),
            Genres(id: 91, name: "Documentary"),
            Genres(id: 92, name: "Western"),
            Genres(id: 93, name: "Feature film"),
            Genres(id: 94, name: "Short film"),
        ]
    }
}
