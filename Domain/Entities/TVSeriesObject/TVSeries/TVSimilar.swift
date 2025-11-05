//
//  TVSimilar.swift
//  MovieApp
//
//  Created by VladOS on 02.11.2025.
//

import Foundation

struct TVSimilar: Hashable {
    let id: Int
    let name: String
    let originalName: String?
    let posterPath: String?
    let firstAirDate: String?
    let backdropPath: String?
    let genreIDs: [Int]?
    let overview: String?
    let voteAverage: Double?
    let isLocalImage: Bool
}

extension TVSimilar {
    
    init(dto: TVSeriesSimilarDTO) {
        self.id = dto.id
        self.name = dto.name
        self.originalName = dto.originalName
        self.posterPath = dto.posterPath
        self.firstAirDate = dto.firstAirDate
        self.backdropPath = dto.backdropPath
        self.genreIDs = dto.genreIDs
        self.overview = dto.overview
        self.voteAverage = dto.voteAverage
        self.isLocalImage = false
    }
    
    static func mockTVSimilar() -> [TVSimilar] {
        return [
            
            TVSimilar(id: 1, name: "Game of Thrones", originalName: "Game of Thrones", posterPath: "series1", firstAirDate: "2011-04-17", backdropPath: "", genreIDs: [18, 10765],
                      overview: "Nine noble families wage war against each other in order to gain control over the mythical land of Westeros.", voteAverage: 9.5, isLocalImage: true),
            
            TVSimilar(id: 2, name: "Breaking Bad", originalName: "Breaking Bad", posterPath: "series2", firstAirDate: "2008-01-20", backdropPath: "", genreIDs: [80, 18],
                      overview: "A high school chemistry teacher turned methamphetamine producer teams up with a former student to secure his family's future.", voteAverage: 9.6, isLocalImage: true),
            
            TVSimilar(id: 3, name: "The Witcher", originalName: "The Witcher", posterPath: "series3", firstAirDate: "2019-12-20", backdropPath: "", genreIDs: [18, 10765],
                      overview: "Geralt of Rivia, a solitary monster hunter, struggles to find his place in a world where people often prove more wicked than beasts.", voteAverage: 8.2, isLocalImage: true)
        ]
    }
}
