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
    
    var title: String {
        switch self {
        case .genresMovie: return "Discover Your Next Favorite Movies"
        case .topMovie: return "Top 10 Movies This Week"
        case .upcomingMovie: return "Upcoming"
        }
    }
    
    var shouldShowSeeAll: Bool {
        switch self {
        case .topMovie: return true
        default: return false
        }
    }
}

struct CollectionSection {
    let type: MainSectionType
    let items: [CollectionItem]
}
