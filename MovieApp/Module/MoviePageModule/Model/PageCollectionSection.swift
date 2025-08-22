//
//  PageCollectionSection.swift
//  MovieApp
//
//  Created by VladOS on 22.08.2025.
//

import Foundation

enum MoviePageSectionType {
    case posterMovie
//    case stackButton
//    case specificationMovie
//    case trailerMovie
}

struct PageCollectionSection {
    let type: MoviePageSectionType
    let items: [CollectionItem]
}
