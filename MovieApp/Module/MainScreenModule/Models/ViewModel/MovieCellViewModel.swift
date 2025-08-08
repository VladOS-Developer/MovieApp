//
//  MovieCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import UIKit

struct MovieCellViewModel: Equatable {
    let title: String
    let runtimeText: String
    let releaseDateText: String
    let genresText: String
    let posterImage: UIImage?
    let posterURL: URL?
    
    init(movie: Movie, genres: [Genre]) {
        self.title = movie.title
        
        if let runtime = movie.runtime {
            let hours = runtime / 60
            let minutes = runtime % 60
            self.runtimeText = "\(hours)h \(minutes)min"
        } else {
            self.runtimeText = ""
        }
        
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
        
        let genreNames = genres
            .filter { movie.genreIDs.contains($0.id) }
            .map { $0.name }
        self.genresText = genreNames.joined(separator: " / ")
        
        if movie.isLocalImage {
            self.posterImage = UIImage(named: movie.posterPath ?? "")
            self.posterURL = nil
        } else {
            self.posterImage = nil
            if let path = movie.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.posterURL = nil
            }
        }
    }
}
