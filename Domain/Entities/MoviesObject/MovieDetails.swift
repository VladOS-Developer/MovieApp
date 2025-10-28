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
        self.genreIDs = dto.genreIDs ?? dto.genres?.map { $0.id } ?? []
        self.genres = dto.genres?.map { Genres(dto: $0) }
        self.overview = dto.overview
        self.productionCountries = dto.productionCountries?.map { ProductionCountry(iso3166_1: $0.iso3166_1, name: $0.name) }
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
    }
    
    static func mockTopMovieDetails() -> [MovieDetails] {
        return [
            MovieDetails(id: 1, title: "Avatar", originalTitle: "The Way of Water", posterPath: "film1", backdropPath: "", runtime: 169, releaseDate: "2022-12-14", genreIDs: [28, 12], genres: [],
                         overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolvedOn the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved", productionCountries: [ProductionCountry(iso3166_1: "US", name: "United States")], voteAverage: 8, isLocalImage: true),
            
            MovieDetails(id: 2, title: "Avengers", originalTitle: "Infinity War", posterPath: "film2", backdropPath: "", runtime: 155, releaseDate: "2025-10-10", genreIDs: [12], genres: [],
                         overview: "As the Avengers and their allies continue to protect the world from various dangers that a single superhero could not handle, a new threat emerges from outer space: Thanos. The intergalactic tyrant is on a mission to collect all six Infinity Stones, artifacts of incredible power that can be used to alter reality at will. Everything the Avengers had faced before had led to this point—Earth's fate had never been more uncertain.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 4, isLocalImage: true),
            
            MovieDetails(id: 3, title: "The Dark Knight", originalTitle: "Batman raises the stakes", posterPath: "film3", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878], genres: [],
                         overview: "Batman raises the stakes in the war on crime. With the help of Lieutenant Jim Gordon and prosecutor Harvey Dent, he intends to clear the streets of the crime that poisons the city. The cooperation proves effective, but they soon find themselves in the midst of chaos unleashed by a rising criminal mastermind known to the frightened townspeople as the Joker.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 5, isLocalImage: true),
            
            MovieDetails(id: 4, title: "Placeholder", originalTitle: "", posterPath: "img11", backdropPath: "", runtime: 136, releaseDate: "2025-10-10", genreIDs: [878], genres: [],
                         overview: "On the lush alien world of Pandora live the Na’vi, beings who appear primitive but are highly evolved.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 0, isLocalImage: true),
        ]
    }
    
    static func mockUpcomingMovieDetails() -> [MovieDetails] {
        return [
            MovieDetails(id: 5, title: "Matrix: Reloaded", originalTitle: "", posterPath: "film4", backdropPath: "", runtime: 169, releaseDate: "2025-09-01", genreIDs: [12], genres: [],
                         overview: "In The Matrix Reloaded, Zion is under attack by the Machine Army, forcing Neo, Trinity, and Morpheus to find a way to save humanity. As a prophesied One, Neo learns the Matrix is a recurring system designed to be rebooted, not destroyed, and is given a choice by the Architect: save the imperiled Zion by rebooting the Matrix, or save Trinity by letting the system crash and killing everyone. Neo chooses to save Trinity, gaining new powers to fight the now-free Agent Smith.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 9, isLocalImage: true),
            
            MovieDetails(id: 6, title: "Dune: Part Two", originalTitle: "", posterPath: "film5", backdropPath: "", runtime: 155, releaseDate: "2025-10-10", genreIDs: [16], genres: [],
                         overview: "Dune: Part Two continues the story of Paul Atreides, who teams up with the Fremen and their leader Chani to fight the Harkonnen, avenge the murder of his father, and liberate the planet Arrakis. As the plot progresses, Paul accepts his fate as a messiah, gains great power and power, but is forced to choose between his love for Chani and the fate of the universe. Paul faces many challenges, including a battle with Feyd-Rauta Harkonnen and the Emperor, which leads to a rebellion and a holy war against the entire galaxy.", productionCountries: [ProductionCountry(iso3166_1: "", name: "United States")], voteAverage: 6, isLocalImage: true)
        ]
    }
}
