//
//  Genre.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct Genre: Hashable {
    let id: Int
    let name: String
}

extension Genre {
    init(dto: GenreDTO) {
        self.id = dto.id
        self.name = dto.name
    }
}

extension Genre {
    static func mockGenres() -> [Genre] {
        return [
            Genre(id: 12, name: "Adventure"),
            Genre(id: 16, name: "Animation"),
            Genre(id: 18, name: "Drama"),
            Genre(id: 27, name: "Horror"),
            Genre(id: 28, name: "Action"),
            Genre(id: 35, name: "Comedy"),
            Genre(id: 80, name: "Crime"),
            Genre(id: 878, name: "Sci-Fi"),
            Genre(id: 88, name: "Thriller"),
            Genre(id: 89, name: "Fantasy"),
            Genre(id: 90, name: "Mystery"),
            Genre(id: 91, name: "Documentary"),
            Genre(id: 92, name: "Western"),
            Genre(id: 93, name: "Feature film"),
            Genre(id: 94, name: "Short film"),
        ]
    }
}
