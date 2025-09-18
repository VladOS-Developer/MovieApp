//
//  ActorPageCollectionItem.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import Foundation

enum ActorPageCollectionItem: Hashable {
    case header(ActorHeaderCellViewModel)
    case filmography(ActorMovieCellViewModel)
    case biography(ActorBiographyCellViewModel)

    var id: String {
        switch self {
        case .header(let vm): return "header_\(vm.id)"
        case .filmography(let vm): return "filmography_\(vm.id)"
        case .biography(let vm): return "biography_\(vm.id)"
            
        }
    }
}
