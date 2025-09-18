//
//  ActorHeaderCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import UIKit

struct ActorHeaderCellViewModel: Hashable {
    let id: Int
    let name: String
    let profileURL: URL?
    let profileImage: UIImage?
    let birthday: String?
    let placeOfBirth: String?
    let biography: String?
    
    let moviesCountText: String
    
    init(actorDetails: ActorDetails, actorMovies: [ActorMovie]) {
        self.id = actorDetails.id
        self.name = actorDetails.name
        self.birthday = actorDetails.birthday
        self.placeOfBirth = actorDetails.placeOfBirth
        self.biography = actorDetails.biography
        
        self.moviesCountText = "\(actorMovies.count) Movies"
        
        // images
        if actorDetails.isLocalImage {
            self.profileImage = UIImage(named: actorDetails.profilePath ?? "")
            self.profileURL = nil
        } else {
            self.profileImage = nil
            if let path = actorDetails.profilePath {
                self.profileURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.profileURL = nil
            }
        }
    }
    
}
