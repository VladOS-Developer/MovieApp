//
//  MainCollectionSection.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import Foundation

struct MainCollectionSection {
    let type: MainSectionType
    var items: [MainCollectionItem]
}

enum MainSectionType {
    case searchHeader
    case searchResults
    case genresMovie
    case topMovie
    case tvSeries
    case upcomingMovie
    
    
    var title: String {
        switch self {
        case .searchHeader: return ""
        case .searchResults: return ""
        case .genresMovie: return "Discover Your Next Favorite Movies"
        case .topMovie: return "Top Movies This Week"
        case .tvSeries: return "Top Series"
        case .upcomingMovie: return "Upcoming Movies"
       
        }
    }
    
}

