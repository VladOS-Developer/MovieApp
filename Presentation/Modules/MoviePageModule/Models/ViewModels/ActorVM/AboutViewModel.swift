//
//  AboutViewModel.swift
//  MovieApp
//
//  Created by VladOS on 14.09.2025.
//

import Foundation

struct AboutViewModel: Hashable {
    let spokenLanguagesText: String?   // можно nil
    let cast: [CastCellViewModel]
    let crew: [CrewCellViewModel]
}
