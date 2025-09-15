//
//  ActorBiographyCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import UIKit

struct ActorBiographyCellViewModel: Hashable {
    let id: Int
    let biography: String
    let birthday: String?
    let placeOfBirth: String?

    init(actor: Actor) {
        self.id = actor.id
        self.biography = actor.biography ?? "No biography available"
        self.birthday = actor.birthday
        self.placeOfBirth = actor.placeOfBirth
    }
}
