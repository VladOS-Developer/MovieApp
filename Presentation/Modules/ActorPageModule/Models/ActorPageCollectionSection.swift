//
//  ActorPageCollectionSection.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import Foundation

struct ActorPageCollectionSection {
    let type: ActorPageSectionType
    var items: [ActorPageCollectionItem]
}

enum ActorPageSectionType {
    case header
    case socialStackButtons
    case actorSegmentedTabs
    case filmography
//    case biography

}
