//
//  TVDetailsCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

struct TVDetailsCellViewModel: Hashable {
    let id: Int
    let title: String
    
    var posterImage: UIImage?
    var posterURL: URL?
    let backdropURL: URL?
    
    let ratingText: String
    let ratingValue: Double?
    
    let runtimeText: String
    let genresText: String
    let releaseDateText: String
    let countryText: String
    let overview: String?
    
    init(tvDetails: TVDetails, tvGenres: [TVGenres]) {
        self.id = tvDetails.id
        self.title = tvDetails.name
        self.overview = tvDetails.overview
        
        // images
        if tvDetails.isLocalImage {
            self.posterImage = UIImage(named: tvDetails.posterPath ?? "")
            self.posterURL = nil
            self.backdropURL = nil
        } else {
            self.posterImage = nil
            if let path = tvDetails.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.posterURL = nil
            }
            
            if let backdrop = tvDetails.backdropPath {
                self.backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdrop)")
            } else {
                self.backdropURL = nil
            }
        }
        
        // rating
        if let value = tvDetails.voteAverage, value > 0 {
            self.ratingValue = value
            self.ratingText = String(format: "%.1f", value)
        } else {
            self.ratingValue = nil
            self.ratingText = "-"
        }
        
        // runtime
        if let runtimes = tvDetails.episodeRunTime, let runtime = runtimes.first {
            let hours = runtime / 60
            let minutes = runtime % 60
            self.runtimeText = "\(hours)h \(minutes)min"
        } else {
            self.runtimeText = "-"
        }
        
        // genres
        let genresList = (tvDetails.genres?.map { $0.name })
            ?? tvGenres.filter { tvDetails.genreIDs.contains($0.id) }.map { $0.name }

        self.genresText = genresList.joined(separator: " / ")
        
        // releaseDate
        if let dateString = tvDetails.firstAirDate {
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
        if let productionCountries = tvDetails.productionCountries, !productionCountries.isEmpty {
            // На случай, если name может быть nil
            let names = productionCountries.compactMap { $0.name }
            self.countryText = names.joined(separator: ", ")
        } else {
            self.countryText = "-"
        }
        
        
    }
}
