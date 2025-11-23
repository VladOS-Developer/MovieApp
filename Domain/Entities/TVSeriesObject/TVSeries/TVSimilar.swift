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
    
    static func mockTVSimilar(for tvId: Int) -> [TVSimilar] {
        switch tvId {
        case 1399: // Game of Thrones
            return [
                TVSimilar(id: 1396, name: "Breaking Bad", originalName: "Breaking Bad", posterPath: "series2",
                          firstAirDate: "2008-01-20", backdropPath: "", genreIDs: [80, 18],
                          overview: "A chemistry teacher becomes a drug lord.", voteAverage: 9.5, isLocalImage: true)
            ]
        case 1396: // Breaking Bad
            return [
                TVSimilar(id: 66732, name: "Stranger Things", originalName: "Stranger Things", posterPath: "series3",
                          firstAirDate: "2016-07-15", backdropPath: "", genreIDs: [18, 9648, 10765],
                          overview: "Kids discover a dark secret in Hawkins.", voteAverage: 8.6, isLocalImage: true)
            ]
        case 66732:
            return [
                TVSimilar(id: 1402, name: "The Walking Dead", originalName: "The Walking Dead", posterPath: "series4",
                          firstAirDate: "2010-10-31", backdropPath: "", genreIDs: [18, 10759, 10765],
                          overview: "Survivors face a zombie world.", voteAverage: 8.2, isLocalImage: true)
            ]
        default:
            return []
        }
    }
}
