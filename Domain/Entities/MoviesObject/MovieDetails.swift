//
//  MovieDetails.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct ProductionCountry: Hashable {
    let iso3166_1: String
    let name: String
}

struct MovieDetails: Hashable {
    let id: Int
    let title: String
    let originalTitle: String?
    let posterPath: String?
    let backdropPath: String?
    let runtime: Int?
    let releaseDate: String?
    let genreIDs: [Int]
    let genres: [Genres]?
    let overview: String?
    let productionCountries: [ProductionCountry]?
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
        self.genres = dto.genres?.map { Genres(dto: $0) }
        self.overview = dto.overview
        self.productionCountries = dto.productionCountries?.map { ProductionCountry(iso3166_1: $0.iso3166_1, name: $0.name) }
        self.voteAverage = dto.voteAverage
        
        self.isLocalImage = false
    }
}

extension MovieDetails {
    static func mockTopMovieDetails() -> [MovieDetails] {
        return [
            MovieDetails(id: 1, title: "Avatar", originalTitle: "The Way of Water", posterPath: "img12", backdropPath: "", runtime: 169, releaseDate: "2022-12-14", genreIDs: [28, 12], genres: [],
                         overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolvedOn the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved", productionCountries: [ProductionCountry(iso3166_1: "US", name: "United States")], voteAverage: 8, isLocalImage: true),
            
            MovieDetails(id: 2, title: "Avengers", originalTitle: "Infinity War", posterPath: "img13", backdropPath: "", runtime: 155, releaseDate: "2025-10-10", genreIDs: [12], genres: [],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 4, isLocalImage: true),
            
            MovieDetails(id: 3, title: "The Dark Knight", originalTitle: "Batman raises the stakes", posterPath: "img14", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878], genres: [],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 0, isLocalImage: true),
            
            MovieDetails(id: 4, title: "Placeholder", originalTitle: "", posterPath: "img11", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878], genres: [],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 5, isLocalImage: true),
        ]
    }

    static func mockUpcomingMovieDetails() -> [MovieDetails] {
        return [
            MovieDetails(id: 5, title: "Percy Jackson", originalTitle: "", posterPath: "img5", backdropPath: "", runtime: 169, releaseDate: "2025-09-01", genreIDs: [12], genres: [],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved(Pakanajuhla).", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 8, isLocalImage: true),
            
            MovieDetails(id: 6, title: "Inception", originalTitle: "", posterPath: "img7", backdropPath: "", runtime: 155, releaseDate: "2025-10-10", genreIDs: [16], genres: [],
                  overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 4, isLocalImage: true)
        ]
    }
}
