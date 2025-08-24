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
    let originalTitle: String?
    
    let posterPath: String?
    let backdropPath: String?
    
    let runtime: Int?
    let releaseDate: String?
    
    let genreIDs: [Int]
    let overview: String?
    let originCountry: [String]?
    let voteAverage: Double?
    
    let isLocalImage: Bool
}

extension Movie {
    init(dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.originalTitle = dto.original_title
        
        self.posterPath = dto.poster_path
        self.backdropPath = dto.backdrop_path
        
        self.runtime = dto.runtime
        self.releaseDate = dto.release_date
        
        self.genreIDs = dto.genre_ids
        self.overview = dto.overview
        self.originCountry = dto.origin_country
        self.voteAverage = dto.vote_average
        
        self.isLocalImage = false
    }
}

extension Movie {
    static func mockTopMovies() -> [Movie] {
        return [
            Movie(id: 1, title: "John Wick", originalTitle: "Chapter 1", posterPath: "img1", backdropPath: "", runtime: 169, releaseDate: "2025-09-01", genreIDs: [28],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 7.5, isLocalImage: true),
            
            Movie(id: 2, title: "Avatar", originalTitle: "The Way Of Water", posterPath: "img2", backdropPath: "", runtime: 155, releaseDate: "2025-10-10", genreIDs: [12],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 4.5, isLocalImage: true),
            
            Movie(id: 3, title: "The Matrix", originalTitle: "", posterPath: "img3", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 0, isLocalImage: true),
            
            Movie(id: 4, title: "The Matrix", originalTitle: "", posterPath: "img4", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 0, isLocalImage: true),
            
            Movie(id: 5, title: "The Matrix", originalTitle: "", posterPath: "img5", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 0, isLocalImage: true),
        ]
    }

    static func mockUpcomingMovies() -> [Movie] {
        return [
            Movie(id: 10, title: "Percy Jackson", originalTitle: "", posterPath: "img8", backdropPath: "", runtime: nil, releaseDate: "2025-09-01", genreIDs: [12],
                  overview: "", originCountry: [""], voteAverage: 0, isLocalImage: true),
            
            Movie(id: 11, title: "Inception", originalTitle: "", posterPath: "img9", backdropPath: "", runtime: nil, releaseDate: "2025-10-10", genreIDs: [16],
                  overview: "", originCountry: [""], voteAverage: 0, isLocalImage: true)
        ]
    }
}
