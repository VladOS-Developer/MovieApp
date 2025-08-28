//
//  MainCollectionSection.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct MainCollectionSection {
    let type: MainSectionType
    let items: [MainCollectionItem]
}

enum MainSectionType {
    case genresMovie
    case topMovie
    case upcomingMovie
    
    var title: String {
        switch self {
        case .genresMovie: return "Discover Your Next Favorite Movies"
        case .topMovie: return "Top Movies This Week"
        case .upcomingMovie: return "Upcoming"
        }
    }
    
}

