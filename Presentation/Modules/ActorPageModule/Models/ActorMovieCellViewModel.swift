//
//  ActorMovieCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 18.09.2025.
//

import UIKit

struct ActorMovieCellViewModel: Hashable {
    let id: Int
    let title: String
    var posterURL: URL?
    var posterImage: UIImage?
    let releaseDateText: String
    
    init(actorMovie: ActorMovie) {
        self.id = actorMovie.id
        self.title = actorMovie.title
        
        // images
        if actorMovie.isLocalImage {
            self.posterImage = UIImage(named: actorMovie.posterPath ?? "")
            self.posterURL = nil
        } else {
            self.posterImage = nil
            if let path = actorMovie.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.posterURL = nil
            }
        }
        
        // releaseDate
        if let dateString = actorMovie.releaseDate {
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
