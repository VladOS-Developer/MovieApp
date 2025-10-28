//
//  MovieSimilar.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import Foundation

struct MovieSimilar: Hashable {
    let id: Int
    let title: String
    let originalTitle: String?
    let posterPath: String?
    let releaseDate: String?
    let backdropPath: String?
    let genreIDs: [Int]?
    let overview: String?
    let voteAverage: Double?
    let isLocalImage: Bool
}

extension MovieSimilar {
    
    init(dto: MovieSimilarDTO) {
        self.id = dto.id
        self.title = dto.title
        self.originalTitle = dto.originalTitle
        self.posterPath = dto.posterPath
        self.releaseDate = dto.releaseDate
        self.backdropPath = dto.backdropPath
        self.genreIDs = dto.genreIDs
        self.overview = dto.overview
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
    }
    
    static func mockSimilarMovies() -> [MovieSimilar] {
        return [
            MovieSimilar(id: 1, title: "Inception1", originalTitle: "The Way Of Water", posterPath: "film1", releaseDate: "2010-07-16", backdropPath: "", genreIDs: [18],
                         overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved(1).", voteAverage: 8, isLocalImage: true),
            
            MovieSimilar(id: 2, title: "Inception2", originalTitle: "The Way Of Water", posterPath: "film2", releaseDate: "2010-07-16", backdropPath: "", genreIDs: [28],
                         overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved(2).", voteAverage: 4, isLocalImage: true),
            
            MovieSimilar(id: 3, title: "Inception3", originalTitle: "The Way Of Water", posterPath: "film3", releaseDate: "2010-07-16", backdropPath: "", genreIDs: [88],
                         overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved(3).", voteAverage: 5, isLocalImage: true),
                        
        ]
    }
}

