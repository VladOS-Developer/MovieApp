//
//  TVSeriesDetails.swift
//  MovieApp
//
//  Created by VladOS on 01.11.2025.
//

import Foundation

struct TVSeriesProductionCountry: Hashable {
    let iso3166_1: String
    let name: String
}

struct TVSeriesDetails: Hashable {
    let id: Int
    let name: String
    let originalName: String?
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    let lastAirDate: String?
    let numberOfSeasons: Int?
    let numberOfEpisodes: Int?
    let episodeRunTime: [Int]?
    let overview: String?
    let genreIDs: [Int]
    let genres: [TVSeriesGenres]?
    let originCountry: [String]?
    let productionCountries: [TVSeriesProductionCountry]?
    let voteAverage: Double?
    let isLocalImage: Bool
}

extension TVSeriesDetails {
    init(dto: TVSeriesDetailsDTO) {
        self.id = dto.id
        self.name = dto.name
        self.originalName = dto.originalName
        self.posterPath = dto.posterPath
        self.backdropPath = dto.backdropPath
        self.firstAirDate = dto.firstAirDate
        self.lastAirDate = dto.lastAirDate
        self.numberOfSeasons = dto.numberOfSeasons
        self.numberOfEpisodes = dto.numberOfEpisodes
        self.episodeRunTime = dto.episodeRunTime
        self.overview = dto.overview
        self.genreIDs = dto.genreIDs ?? dto.genres?.map { $0.id } ?? []
        self.genres = dto.genres?.map { TVSeriesGenres(id: $0.id, name: $0.name) }
        self.originCountry = dto.originCountry
        self.productionCountries = dto.productionCountries?.map { TVSeriesProductionCountry(iso3166_1: $0.iso3166_1, name: $0.name) }
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
    }
    
    static func mockTopRatedTVSeries() -> [TVSeriesDetails] {
            [
                TVSeriesDetails(id: 101,
                                name: "Breaking Bad",
                                originalName: "",
                                posterPath: "series2",
                                backdropPath: "",
                                firstAirDate: "2008-01-20",
                                lastAirDate: "2013-09-29",
                                numberOfSeasons: 5,
                                numberOfEpisodes: 62,
                                episodeRunTime: [47],
                                overview: "A high school chemistry teacher turned meth producer...",
                                genreIDs: [80, 18],
                                genres: [],
                                originCountry: ["US"],
                                productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                                voteAverage: 9.5,
                                isLocalImage: true)
            ]
        }

        static func mockPopularTVSeries() -> [TVSeriesDetails] {
            [
                TVSeriesDetails(id: 102,
                                name: "Game of Thrones",
                                originalName: "",
                                posterPath: "series1",
                                backdropPath: "",
                                firstAirDate: "2011-04-17",
                                lastAirDate: "2019-05-19",
                                numberOfSeasons: 8,
                                numberOfEpisodes: 73,
                                episodeRunTime: [55],
                                overview: "Nine noble families fight for control...",
                                genreIDs: [10765, 18],
                                genres: [],
                                originCountry: ["US"],
                                productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                                voteAverage: 8.7,
                                isLocalImage: true)
            ]
        }
}
