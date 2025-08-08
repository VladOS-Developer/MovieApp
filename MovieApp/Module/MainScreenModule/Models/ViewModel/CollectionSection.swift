//
//  CollectionSection.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

enum MainSectionType {
    case genresMovie
    case topMovie
    case upcomingMovie
}

struct CollectionSection {
    let type: MainSectionType
    let items: [CollectionItem]
}
