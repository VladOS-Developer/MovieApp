//
//  CastCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import UIKit

struct CastCellViewModel: Hashable {
    let id: Int
    let name: String
    let character: String?
    let profileURL: URL?
    let profileImage: UIImage?

    init(cast: CastMember) {
        self.id = cast.id
        self.name = cast.name
        self.character = cast.character
        
        // images
        if cast.isLocalImage {
            self.profileImage = UIImage(named: cast.profilePath ?? "")
            self.profileURL = nil
        } else {
            self.profileImage = nil
            if let path = cast.profilePath {
                self.profileURL = URL(string: "https://image.tmdb.org/t/p/w185\(path)")
            } else {
                self.profileURL = nil
            }
            
        }
    }
}
