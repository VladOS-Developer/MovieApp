//
//  ActorMovieCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import UIKit

struct ActorMovieCellViewModel: Hashable {
    let id: Int
    let title: String
    let releaseDateText: String
    let character: String?
    let posterImage: UIImage?
    let posterURL: URL?

    init(movie: ActorMovie) {
        self.id = movie.id
        self.title = movie.title
        self.character = movie.character

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

        if let path = movie.posterPath {
            self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            self.posterImage = nil
        } else {
            self.posterURL = nil
            self.posterImage = UIImage(named: "placeholder_poster")
        }
    }
}
