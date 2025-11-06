//
//  TVSeries.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import Foundation

struct TVSeries: Hashable {
    
    let id: Int
    let name: String
    let originalName: String?
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let firstAirDate: String?
    let genreIDs: [Int]
    let voteAverage: Double?
    let isLocalImage: Bool
}

extension TVSeries {
    
    init(dto: TVSeriesTopRateDTO) {
        self.id = dto.id
        self.name = dto.name
        self.originalName = dto.originalName
        self.posterPath = dto.posterPath
        self.backdropPath = dto.backdropPath
        self.overview = dto.overview
        self.firstAirDate = dto.firstAirDate
        self.genreIDs = dto.genreIDs ?? []
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
        
    }
    
    init(dto: TVSeriesPopularDTO) {
        self.id = dto.id
        self.name = dto.name
        self.originalName = dto.originalName
        self.posterPath = dto.posterPath
        self.backdropPath = dto.backdropPath
        self.overview = dto.overview
        self.firstAirDate = dto.firstAirDate
        self.genreIDs = dto.genreIDs ?? []
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
        
    }
    
    static func mockSeriesTopRate() -> [TVSeries] {
        return [
            TVSeries(id: 1399, name: "Game of Thrones", originalName: "Game of Thrones",
                     posterPath: "series1", backdropPath: nil,
                     overview: "Nine noble families wage war against each other in order to gain control over Westeros.",
                     firstAirDate: "2011-04-17", genreIDs: [10765, 18, 10759],
                     voteAverage: 8.4, isLocalImage: true),
            
            TVSeries(id: 1396, name: "Breaking Bad", originalName: "Breaking Bad",
                     posterPath: "series2", backdropPath: nil,
                     overview: "A chemistry teacher turned meth producer navigates the criminal underworld.",
                     firstAirDate: "2008-01-20", genreIDs: [18, 80],
                     voteAverage: 8.9, isLocalImage: true),
            
            TVSeries(id: 66732, name: "Stranger Things", originalName: "Stranger Things",
                     posterPath: "series3", backdropPath: nil,
                     overview: "Kids uncover supernatural forces in their small town.",
                     firstAirDate: "2016-07-15", genreIDs: [18, 9648, 10765],
                     voteAverage: 8.6, isLocalImage: true),
            
            TVSeries(id: 1402, name: "The Walking Dead", originalName: "The Walking Dead",
                     posterPath: "series4", backdropPath: nil,
                     overview: "Rick Grimes leads survivors in a zombie world.",
                     firstAirDate: "2010-10-31", genreIDs: [18, 10759, 10765],
                     voteAverage: 8.2, isLocalImage: true)
        ]
    }
    
    static func mockSeriesPopular() -> [TVSeries] {
        
        return [
            TVSeries(id: 1399, name: "Game of Thrones", originalName: "Game of Thrones",
                     posterPath: "series1", backdropPath: nil,
                     overview: "Nine noble families wage war against each other in order to gain control over Westeros.",
                     firstAirDate: "2011-04-17", genreIDs: [10765, 18, 10759],
                     voteAverage: 8.4, isLocalImage: true),
            
            TVSeries(id: 1396, name: "Breaking Bad", originalName: "Breaking Bad",
                     posterPath: "series2", backdropPath: nil,
                     overview: "A chemistry teacher turned meth producer navigates the criminal underworld.",
                     firstAirDate: "2008-01-20", genreIDs: [18, 80],
                     voteAverage: 8.9, isLocalImage: true),
            
            TVSeries(id: 66732, name: "Stranger Things", originalName: "Stranger Things",
                     posterPath: "series3", backdropPath: nil,
                     overview: "Kids uncover supernatural forces in their small town.",
                     firstAirDate: "2016-07-15", genreIDs: [18, 9648, 10765],
                     voteAverage: 8.6, isLocalImage: true),
            
            TVSeries(id: 1402, name: "The Walking Dead", originalName: "The Walking Dead",
                     posterPath: "series4", backdropPath: nil,
                     overview: "Rick Grimes leads survivors in a zombie world.",
                     firstAirDate: "2010-10-31", genreIDs: [18, 10759, 10765],
                     voteAverage: 8.2, isLocalImage: true)
        ]
    }
}
