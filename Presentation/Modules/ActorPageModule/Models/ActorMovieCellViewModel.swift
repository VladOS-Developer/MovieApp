//
//  ActorMovieCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 18.09.2025.
//

import UIKit

struct ActorMovieCellViewModel: Hashable {
    let id: Int
    let posterURL: URL?
    let posterImage: UIImage?
    
    init(actorMovie: ActorMovie) {
        self.id = actorMovie.id
        
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
    }
    
}
