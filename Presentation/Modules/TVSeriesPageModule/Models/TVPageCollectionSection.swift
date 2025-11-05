//
//  TVPageCollectionSection.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import Foundation

struct TVPageCollectionSection {
    let type: TVPageSectionType
    var items: [TVPageCollectionItem]
}

enum TVPageSectionType {
    case posterTV
    case stackButtonsTV
    case specificationTV
    case overviewTV
    case videoTV
    case segmentedTabsTV
    case dynamicContentTV
}
