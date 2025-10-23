//
//  ActorImagesCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 17.09.2025.
//

import UIKit

struct ActorImagesCellViewModel: Hashable {
    let id: String
    let filePath: String?
    var image: UIImage?
    var imageURL: URL?
    
    init(actorImage: ActorImages) {
        self.id = actorImage.id
        self.filePath = actorImage.filePath
        
        // images
        if actorImage.isLocalImage {
            self.image = UIImage(named: actorImage.filePath ?? "")
            self.imageURL = nil
        } else {
            self.image = nil
            if let path = actorImage.filePath {
                self.imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            } else {
                self.imageURL = nil
            }
        }
    }
}
