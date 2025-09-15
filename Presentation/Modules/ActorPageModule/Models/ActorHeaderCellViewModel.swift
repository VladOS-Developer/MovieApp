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

    init(actor: Actor) {
        self.id = actor.id
        self.name = actor.name

        if let path = actor.profilePath {
            self.profileURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            self.profileImage = nil
        } else {
            self.profileURL = nil
            self.profileImage = UIImage(named: "placeholder_actor")
        }
    }
}
