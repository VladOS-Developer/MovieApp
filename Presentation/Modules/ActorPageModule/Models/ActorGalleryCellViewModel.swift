//
//  ActorGalleryCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 17.09.2025.
//

import UIKit

struct ActorGalleryCellViewModel: Hashable {
//    let images: [ActorImages]
    
    let image: UIImage?
    let imageURL: URL?
    
    init(actorImage: ActorImages) {
        
//        if actorImage.isLocalImage {
//            self.image = UIImage(named: actorImage.filePath)
//            self.imageURL = nil
//        } else {
//            self.image = nil
//            self.imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(actorImage.filePath)")
//        }
        
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
