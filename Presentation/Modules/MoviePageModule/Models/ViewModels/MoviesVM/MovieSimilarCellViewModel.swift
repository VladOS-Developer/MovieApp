//
//  MovieSimilarCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import UIKit

struct MovieSimilarCellViewModel: Hashable {
    let id: Int
    let title: String
    let originalTitle: String?
    let overview: String?
    
    let posterImage: UIImage?
    let posterURL: URL?
    let backdropPath: String?
    let backdropURL: URL?
    
    let releaseDate: String?
    let releaseDateText: String
    
    let voteAverage: Double?
    let ratingValue: Double?
    let ratingText: String

    init(movieSimilar: MovieSimilar) {
        self.id = movieSimilar.id
        self.title = movieSimilar.title
        self.originalTitle = movieSimilar.originalTitle
        self.overview = movieSimilar.overview
        self.releaseDate = movieSimilar.releaseDate
        self.voteAverage = movieSimilar.voteAverage
        self.backdropPath = movieSimilar.backdropPath
        
        // images
        if movieSimilar.isLocalImage {
            self.posterImage = UIImage(named: movieSimilar.posterPath ?? "")
            self.posterURL = nil
            self.backdropURL = nil
        } else {
            self.posterImage = nil
            if let path = movieSimilar.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.posterURL = nil
            }
            
            if let backdrop = movieSimilar.backdropPath {
                self.backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdrop)")
            } else {
                self.backdropURL = nil
            }
        }
        
        // rating
        if let value = movieSimilar.voteAverage, value > 0 {
            self.ratingValue = value
            self.ratingText = String(format: "%.1f", value)
        } else {
            self.ratingValue = nil
            self.ratingText = "-"
        }
        
        // releaseDate
        if let dateString = movieSimilar.releaseDate {
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
