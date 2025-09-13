//
//  Movie.swift
//  MovieApp
//
//  Created by VladOS on 05.09.2025.
//

import Foundation

struct Movie: Hashable {
    let id: Int
    let title: String
    let originalTitle: String?
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let genreIDs: [Int]
    let voteAverage: Double?
    
    let isLocalImage: Bool
}

extension Movie {
    init(dto: TopRatedMovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.originalTitle = dto.originalTitle
        self.posterPath = dto.posterPath
        self.backdropPath = dto.backdropPath
        self.overview = dto.overview
        self.releaseDate = dto.releaseDate
        self.genreIDs = dto.genreIDs
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
    }

    init(dto: UpcomingMovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.originalTitle = dto.originalTitle
        self.posterPath = dto.posterPath
        self.backdropPath = dto.backdropPath
        self.overview = dto.overview
        self.releaseDate = dto.releaseDate
        self.genreIDs = dto.genreIDs
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
    }
}

extension Movie {
    static func mockTopRatedMovie() -> [Movie] {
        return [
            Movie(id: 1, title: "Avatar", originalTitle: "The Way of Water",posterPath: "img12", backdropPath: "dark_knight_backdrop.jpg",
                  overview: "", releaseDate: "2008-07-18",genreIDs: [28, 80, 18], voteAverage: 8, isLocalImage: true),
            
            Movie(id: 2, title: "Avengers", originalTitle: "Infinity War",posterPath: "img13", backdropPath: "dark_knight_backdrop.jpg",
                  overview: "", releaseDate: "2008-07-18",genreIDs: [28, 80, 18], voteAverage: 7.4, isLocalImage: true),
            
            Movie(id: 3, title: "The Dark Knight", originalTitle: "Batman raises the stakes",posterPath: "img14", backdropPath: "dark_knight_backdrop.jpg",
                  overview: "", releaseDate: "2008-07-18",genreIDs: [28, 80, 18], voteAverage: 5.2, isLocalImage: true),
            
            Movie(id: 4, title: "Placeholder", originalTitle: "Batman raises the stakes",posterPath: "img11", backdropPath: "dark_knight_backdrop.jpg",
                  overview: "", releaseDate: "2008-07-18",genreIDs: [28, 80, 18], voteAverage: 4.3, isLocalImage: true),
        ]
    }
    
    static func mockUpcomingMovie() -> [Movie] {
        return [
            Movie(id: 5, title: "Dune: Part Two", originalTitle: "Dune: Part Two",posterPath: "img5", backdropPath: "dune2_backdrop.jpg",
                  overview: "Paul Atreides unites with Chani and the Fremen...",releaseDate: "2025-11-20", genreIDs: [12, 878], voteAverage: 9.5, isLocalImage: true),
            
            Movie(id: 6, title: "Dune: Part Two", originalTitle: "Dune: Part Two",posterPath: "img7", backdropPath: "dune2_backdrop.jpg",
                  overview: "Paul Atreides unites with Chani and the Fremen...",releaseDate: "2025-11-20", genreIDs: [12, 878], voteAverage: 7.5, isLocalImage: true),
        ]
    }
}
