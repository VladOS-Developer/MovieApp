//
//  SimilarMovieCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 01.09.2025.
//

import UIKit

struct SimilarMovieCellViewModel: Hashable {
    let id: Int
    let title: String
    let posterImage: UIImage?
    let posterURL: URL?

    init(similar: MovieSimilar, isLocal: Bool = true) {
        self.id = similar.id
        self.title = similar.title

        if isLocal {
            // моки: posterPath = имя картинки в ассетах
            if let name = similar.posterPath {
                self.posterImage = UIImage(named: name)
            } else {
                self.posterImage = nil
            }
            self.posterURL = nil
        } else {
            self.posterImage = nil
            if let path = similar.posterPath {
                self.posterURL = URL(string: "https://image.tmdb.org/t/p/w342\(path)")
            } else {
                self.posterURL = nil
            }
        }
    }
}
