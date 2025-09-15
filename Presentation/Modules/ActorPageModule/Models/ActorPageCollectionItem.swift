//
//  ActorPageCollectionItem.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import Foundation

enum ActorPageCollectionItem: Hashable {
    case header(ActorHeaderCellViewModel)
    case biography(ActorBiographyCellViewModel)
    case movie(ActorMovieCellViewModel)
    case cast(ActorCastCellViewModel)
    case crew(ActorCrewCellViewModel)

    var id: String {
        switch self {
        case .header(let vm): return "header_\(vm.id)"
        case .biography(let vm): return "bio_\(vm.id)"
        case .movie(let vm): return "movie_\(vm.id)"
        case .cast(let vm): return "cast_\(vm.id)"
        case .crew(let vm): return "crew_\(vm.id)"
        }
    }
}
