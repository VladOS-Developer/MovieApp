//
//  PageDetailsCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import UIKit

struct PageDetailsCellViewModel: Hashable {
    let id: Int//
    let title: String//
    
    let posterImage: UIImage?//
    let posterURL: URL?//
    let backdropURL: URL?//
    
    let ratingText: String//
    let ratingValue: Double?//
    
    let runtimeText: String//
    let genresText: String//
    let releaseDateText: String//
    let countryText: String//
    let overview: String?//
    
    init(movieDetails: MovieDetails, genres: [Genres]) {
        self.id = movieDetails.id
        self.title = movieDetails.title
        self.overview = movieDetails.overview
        
        // images
        if movieDetails.isLocalImage {
            self.posterImage = UIImage(named: movieDetails.posterPath ?? "")
            self.posterURL = nil
            self.backdropURL = nil
        } else {
            self.posterImage = nil
            if let path = movieDetails.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.posterURL = nil
            }
            
            if let backdrop = movieDetails.backdropPath {
                self.backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdrop)")
            } else {
                self.backdropURL = nil
            }
        }
        
        // rating
        if let value = movieDetails.voteAverage, value > 0 {
            self.ratingValue = value
            self.ratingText = String(format: "%.1f", value)
        } else {
            self.ratingValue = nil
            self.ratingText = "-"
        }
        
        // runtime
        if let runtime = movieDetails.runtime {
            let hours = runtime / 60
            let minutes = runtime % 60
            self.runtimeText = "\(hours)h \(minutes)min"
        } else {
            self.runtimeText = ""
        }
        
        // genres
        let genreNames = genres
            .filter { movieDetails.genreIDs.contains($0.id) }
            .map { $0.name }
        self.genresText = genreNames.joined(separator: " / ")
        
        // releaseDate
        if let dateString = movieDetails.releaseDate {
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
        
        // country
        if let countries = movieDetails.originCountry, !countries.isEmpty {
            self.countryText = countries.joined(separator: ", ")
        } else {
            self.countryText = ""
        }
        
        
    }
}
