//
//  ActorBiographyCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import UIKit

struct ActorBiographyCellViewModel: Hashable {
    let id: Int
    let name: String // имя
    let biography: String // текст биографии
    let birthday: String? // дата рождения
    let placeOfBirth: String? // место рождения

    init(actor: ActorDetails) {
        self.id = actor.id
        self.name = actor.name
        self.biography = actor.biography ?? "No biography available"
        self.birthday = actor.birthday
        self.placeOfBirth = actor.placeOfBirth
    }
}
