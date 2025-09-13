//
//  ActorCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 13.09.2025.
//

import UIKit

struct ActorCellViewModel: Hashable {
    let id: Int
    let name: String
    let profileImage: UIImage?
    let profileURL: URL?

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
