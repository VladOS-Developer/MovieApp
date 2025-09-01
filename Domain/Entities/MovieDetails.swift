//
//  MovieDetails.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct MovieDetails: Hashable {
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

extension MovieDetails {
    init(dto: MovieDetailsDTO) {
        self.id = dto.id
        self.title = dto.title
        self.originalTitle = dto.originalTitle
        self.posterPath = dto.posterPath
        self.backdropPath = dto.backdropPath
        self.runtime = dto.runtime
        self.releaseDate = dto.releaseDate
        self.genreIDs = dto.genreIDs
        self.overview = dto.overview
        self.originCountry = dto.originCountry
        self.voteAverage = dto.voteAverage
        
        self.isLocalImage = false
    }
}

extension MovieDetails {
    static func mockTopMovieDetails() -> [MovieDetails] {
        return [
            MovieDetails(id: 1, title: "John Wick", originalTitle: "Chapter 1", posterPath: "img1", backdropPath: "", runtime: 169, releaseDate: "2025-09-01", genreIDs: [28],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolvedOn the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved", originCountry: ["United States"], voteAverage: 8, isLocalImage: true),
            
            MovieDetails(id: 2, title: "Avatar", originalTitle: "The Way Of Water", posterPath: "img2", backdropPath: "", runtime: 155, releaseDate: "2025-10-10", genreIDs: [12],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 4, isLocalImage: true),
            
            MovieDetails(id: 3, title: "The Matrix", originalTitle: "", posterPath: "img3", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 0, isLocalImage: true),
            
            MovieDetails(id: 4, title: "The Matrix", originalTitle: "", posterPath: "img4", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 5, isLocalImage: true),
            
            MovieDetails(id: 5, title: "The Matrix", originalTitle: "", posterPath: "img5", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 5, isLocalImage: true),
        ]
    }

    static func mockUpcomingMovieDetails() -> [MovieDetails] {
        return [
            MovieDetails(id: 10, title: "Percy Jackson", originalTitle: "", posterPath: "img8", backdropPath: "", runtime: 169, releaseDate: "2025-09-01", genreIDs: [12],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 8, isLocalImage: true),
            
            MovieDetails(id: 11, title: "Inception", originalTitle: "", posterPath: "img9", backdropPath: "", runtime: 155, releaseDate: "2025-10-10", genreIDs: [16],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", originCountry: ["United States"], voteAverage: 4, isLocalImage: true)
        ]
    }
}
