//
//  TVSimilarCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

struct TVSimilarCellViewModel: Hashable {
    let id: Int
    let title: String
    let originalTitle: String?
    let overview: String?
    
    var posterImage: UIImage?
    var posterURL: URL?
    
    let backdropPath: String?
    let backdropURL: URL?
    
    let releaseDate: String?
    let releaseDateText: String
    
    let voteAverage: Double?
    let ratingValue: Double?
    let ratingText: String

    init(tvSimilar: TVSimilar) {
        self.id = tvSimilar.id
        self.title = tvSimilar.name
        self.originalTitle = tvSimilar.originalName
        self.overview = tvSimilar.overview
        self.releaseDate = tvSimilar.firstAirDate
        self.voteAverage = tvSimilar.voteAverage
        self.backdropPath = tvSimilar.backdropPath
        
        // images
        if tvSimilar.isLocalImage {
            self.posterImage = UIImage(named: tvSimilar.posterPath ?? "")
            self.posterURL = nil
            self.backdropURL = nil
        } else {
            self.posterImage = nil
            if let path = tvSimilar.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.posterURL = nil
            }
            
            if let backdrop = tvSimilar.backdropPath {
                self.backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdrop)")
            } else {
                self.backdropURL = nil
            }
        }
        
        // rating
        if let value = tvSimilar.voteAverage, value > 0 {
            self.ratingValue = value
            self.ratingText = String(format: "%.1f", value)
        } else {
            self.ratingValue = nil
            self.ratingText = "-"
        }
        
        // releaseDate
        if let dateString = tvSimilar.firstAirDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateString) {
                formatter.dateFormat = "dd MMM yyyy"
                self.releaseDateText = formatter.string(from: date)
            } else {
                self.releaseDateText = ""
            }
        } else {
            self.releaseDateText = ""
        }

    }
}
