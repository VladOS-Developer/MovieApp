//
//  PageCollectionSection.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import Foundation

struct PageCollectionSection {
    let type: MoviePageSectionType
    let items: [PageCollectionItem]
}

enum MoviePageSectionType {
    case posterMovie
    case stackButtons
    case specificationMovie
    case overviewMovie
    case videoMovie
    case segmentedTabs
}
