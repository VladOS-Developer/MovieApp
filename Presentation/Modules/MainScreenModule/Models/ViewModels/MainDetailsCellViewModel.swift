//
//  MainDetailsCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import UIKit

struct MainDetailsCellViewModel: Hashable {
    let id: Int//
    let title: String//
    let originalTitle: String?
    
    let runtimeText: String//
    let releaseDateText: String//
    
    let genresText: String//
    let overview: String?
    
    let countryText: String
    
    let ratingText: String
    let ratingValue: Double?
    
    let posterImage: UIImage?//
    let posterURL: URL?//
    let backdropURL: URL?
    
    init(movie: MovieDetails, genres: [Genres]) {
        self.id = movie.id
        self.title = movie.title
        self.originalTitle = movie.originalTitle
        self.overview = movie.overview
        
        // runtime
        if let runtime = movie.runtime {
            let hours = runtime / 60
            let minutes = runtime % 60
            self.runtimeText = "\(hours)h \(minutes)min"
        } else {
            self.runtimeText = ""
        }
        
        // releaseDate
        if let dateString = movie.releaseDate {
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
        
        // genres
        let genreNames = genres
            .filter { movie.genreIDs.contains($0.id) }
            .map { $0.name }
        self.genresText = genreNames.joined(separator: " / ")
        
        // country
        if let countries = movie.originCountry, !countries.isEmpty {
            self.countryText = countries.joined(separator: ", ")
        } else {
            self.countryText = ""
        }
        
        // rating
        if let value = movie.voteAverage, value > 0 {
            self.ratingValue = value
            self.ratingText = String(format: "%.1f", value)
        } else {
            self.ratingValue = nil
            self.ratingText = "-"
        }
        
        // images
        if movie.isLocalImage {
            self.posterImage = UIImage(named: movie.posterPath ?? "")
            self.posterURL = nil
            self.backdropURL = nil
        } else {
            self.posterImage = nil
            if let path = movie.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.posterURL = nil
            }
            
            if let backdrop = movie.backdropPath {
                self.backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdrop)")
            } else {
                self.backdropURL = nil
            }
        }
    }
}
