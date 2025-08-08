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
        ]
    }
}
