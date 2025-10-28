//
//  TVSeriesCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 28.10.2025.
//

import UIKit

struct TVSeriesCellViewModel: Hashable {
    let id: Int
    let title: String
    let originalTitle: String?
    let releaseDateText: String
    let genresText: String
    let overview: String?
    let ratingText: String
    let ratingValue: Double?
    var posterImage: UIImage?
    let posterURL: URL?
    let backdropURL: URL?
    var isFavorite: Bool

    init(tvSeries: TVSeriesLists, genres: [TVGenres], isFavorite: Bool = false) {
        self.id = tvSeries.id
        self.title = tvSeries.name
        self.originalTitle = tvSeries.originalName
        self.overview = tvSeries.overview
        self.isFavorite = isFavorite

        // releaseDate
        if let dateString = tvSeries.firstAirDate {
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
            .filter { tvSeries.genreIDs.contains($0.id) }
            .map { $0.name }
        self.genresText = genreNames.joined(separator: " / ")

        // rating
        if let value = tvSeries.voteAverage, value > 0 {
            self.ratingValue = value
            self.ratingText = String(format: "%.1f", value)
        } else {
            self.ratingValue = nil
            self.ratingText = "-"
        }

        // images
        if tvSeries.isLocalImage {
            self.posterImage = UIImage(named: tvSeries.posterPath ?? "")
            self.posterURL = nil
            self.backdropURL = nil
        } else {
            self.posterImage = nil
            if let path = tvSeries.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.posterURL = nil
            }
            if let backdrop = tvSeries.backdropPath {
                self.backdropURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdrop)")
            } else {
                self.backdropURL = nil
            }
        }
    }
}
