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

struct TVDetails: Hashable {
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
    let genres: [TVGenres]?
    let originCountry: [String]?
    let productionCountries: [TVSeriesProductionCountry]?
    let voteAverage: Double?
    let isLocalImage: Bool
}

extension TVDetails {
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
        self.genres = dto.genres?.map { TVGenres(dto: $0) }
        self.originCountry = dto.originCountry
        self.productionCountries = dto.productionCountries?.map { TVSeriesProductionCountry(iso3166_1: $0.iso3166_1, name: $0.name) }
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
    }
    
    static func mockTopRatedTVSeries() -> [TVDetails] {
        return [
            TVDetails(id: 1399, name: "Game of Thrones", originalName: "Game of Thrones",
                      posterPath: "series1", backdropPath: "", firstAirDate: "2011-04-17",
                      lastAirDate: "2019-05-19", numberOfSeasons: 8, numberOfEpisodes: 73,
                      episodeRunTime: [55],
                      overview: "Nine noble families fight for control over the mythical land of Westeros.",
                      genreIDs: [10765, 18], genres: [],
                      originCountry: ["US"],
                      productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                      voteAverage: 8.7, isLocalImage: true),
            
            TVDetails(id: 1396, name: "Breaking Bad", originalName: "Breaking Bad",
                      posterPath: "series2", backdropPath: "", firstAirDate: "2008-01-20",
                      lastAirDate: "2013-09-29", numberOfSeasons: 5, numberOfEpisodes: 62,
                      episodeRunTime: [47],
                      overview: "A high school chemistry teacher turned meth producer.",
                      genreIDs: [80, 18], genres: [],
                      originCountry: ["US"],
                      productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                      voteAverage: 9.5, isLocalImage: true),
            
            TVDetails(id: 66732, name: "Stranger Things", originalName: "Stranger Things",
                      posterPath: "series3", backdropPath: "", firstAirDate: "2016-07-15",
                      lastAirDate: "2025-05-01", numberOfSeasons: 5, numberOfEpisodes: 45,
                      episodeRunTime: [50],
                      overview: "A group of kids uncover supernatural events in Hawkins.",
                      genreIDs: [18, 9648, 10765], genres: [],
                      originCountry: ["US"],
                      productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                      voteAverage: 8.6, isLocalImage: true),
            
            TVDetails(id: 1402, name: "The Walking Dead", originalName: "The Walking Dead",
                      posterPath: "series4", backdropPath: "", firstAirDate: "2010-10-31",
                      lastAirDate: "2022-11-20", numberOfSeasons: 11, numberOfEpisodes: 177,
                      episodeRunTime: [45],
                      overview: "A sheriff leads survivors through a zombie apocalypse.",
                      genreIDs: [18, 10759, 10765], genres: [],
                      originCountry: ["US"],
                      productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                      voteAverage: 8.2, isLocalImage: true)
        ]
    }
    
    static func mockPopularTVSeries() -> [TVDetails] {
        return [
            TVDetails(id: 1399, name: "Game of Thrones", originalName: "Game of Thrones",
                      posterPath: "series1", backdropPath: "", firstAirDate: "2011-04-17",
                      lastAirDate: "2019-05-19", numberOfSeasons: 8, numberOfEpisodes: 73,
                      episodeRunTime: [55],
                      overview: "Nine noble families fight for control over the mythical land of Westeros.",
                      genreIDs: [10765, 18], genres: [],
                      originCountry: ["US"],
                      productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                      voteAverage: 8.7, isLocalImage: true),
            
            TVDetails(id: 1396, name: "Breaking Bad", originalName: "Breaking Bad",
                      posterPath: "series2", backdropPath: "", firstAirDate: "2008-01-20",
                      lastAirDate: "2013-09-29", numberOfSeasons: 5, numberOfEpisodes: 62,
                      episodeRunTime: [47],
                      overview: "A high school chemistry teacher turned meth producer.",
                      genreIDs: [80, 18], genres: [],
                      originCountry: ["US"],
                      productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                      voteAverage: 9.5, isLocalImage: true),
            
            TVDetails(id: 66732, name: "Stranger Things", originalName: "Stranger Things",
                      posterPath: "series3", backdropPath: "", firstAirDate: "2016-07-15",
                      lastAirDate: "2025-05-01", numberOfSeasons: 5, numberOfEpisodes: 45,
                      episodeRunTime: [50],
                      overview: "A group of kids uncover supernatural events in Hawkins.",
                      genreIDs: [18, 9648, 10765], genres: [],
                      originCountry: ["US"],
                      productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                      voteAverage: 8.6, isLocalImage: true),
            
            TVDetails(id: 1402, name: "The Walking Dead", originalName: "The Walking Dead",
                      posterPath: "series4", backdropPath: "", firstAirDate: "2010-10-31",
                      lastAirDate: "2022-11-20", numberOfSeasons: 11, numberOfEpisodes: 177,
                      episodeRunTime: [45],
                      overview: "A sheriff leads survivors through a zombie apocalypse.",
                      genreIDs: [18, 10759, 10765], genres: [],
                      originCountry: ["US"],
                      productionCountries: [TVSeriesProductionCountry(iso3166_1: "US", name: "United States")],
                      voteAverage: 8.2, isLocalImage: true)
        ]
    }
    
}
