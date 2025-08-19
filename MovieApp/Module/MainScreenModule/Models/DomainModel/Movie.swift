//
//  Movie.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct Movie: Decodable, Hashable {
    let id: Int
    let title: String
    let posterPath: String?
    let runtime: Int?
    let releaseDate: String?
    let genreIDs: [Int]
    let overview: String?
    let isLocalImage: Bool
}

extension Movie {
    init(dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.posterPath = dto.poster_path
        self.runtime = dto.runtime
        self.releaseDate = dto.release_date
        self.genreIDs = dto.genre_ids
        self.overview = dto.overview
        self.isLocalImage = false
    }
}

extension Movie {
    static func mockTopMovies() -> [Movie] {
        return [
            Movie(id: 1, title: "John Wick Chapter 1 John Wick Chapter 1", posterPath: "img1", runtime: 169, releaseDate: "", genreIDs: [28],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", isLocalImage: true),
            
            Movie(id: 2, title: "Avatar", posterPath: "img2", runtime: 154, releaseDate: "", genreIDs: [12],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", isLocalImage: true),
            
            Movie(id: 3, title: "The Matrix", posterPath: "img3", runtime: 136, releaseDate: "", genreIDs: [878],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", isLocalImage: true),
            
            Movie(id: 4, title: "The Matrix", posterPath: "img4", runtime: 136, releaseDate: "", genreIDs: [878],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", isLocalImage: true),
            
            
            Movie(id: 5, title: "The Matrix", posterPath: "img5", runtime: 136, releaseDate: "", genreIDs: [878], overview: "", isLocalImage: true),
            Movie(id: 6, title: "The Matrix", posterPath: "img6", runtime: 136, releaseDate: "", genreIDs: [878], overview: "", isLocalImage: true),
            Movie(id: 7, title: "The Matrix", posterPath: "img7", runtime: 136, releaseDate: "", genreIDs: [878], overview: "", isLocalImage: true),
        ]
    }

    static func mockUpcomingMovies() -> [Movie] {
        return [
            Movie(id: 10, title: "Percy Jackson", posterPath: "img8", runtime: nil, releaseDate: "2025-09-01", genreIDs: [12],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", isLocalImage: true),
            Movie(id: 11, title: "Inception", posterPath: "img9", runtime: nil, releaseDate: "2025-10-10", genreIDs: [16],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", isLocalImage: true),
            Movie(id: 12, title: "Percy Jackson", posterPath: "img10", runtime: nil, releaseDate: "2025-09-01", genreIDs: [18], overview: "", isLocalImage: true),
            Movie(id: 13, title: "Percy Jackson", posterPath: "img11", runtime: nil, releaseDate: "2025-09-01", genreIDs: [27], overview: "", isLocalImage: true)
        ]
    }
}
