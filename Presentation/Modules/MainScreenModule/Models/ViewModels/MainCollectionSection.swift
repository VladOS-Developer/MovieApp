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
    case tmdbAttribution
    case searchHeader
    case searchResults
    case genresMovie
    case topMovie
    case tvSeries
    case upcomingMovie
    
    
    var title: String {
        switch self {
        case .tmdbAttribution: return ""
        case .searchHeader: return ""
        case .searchResults: return ""
        case .genresMovie: return "Choose your favorite genre"
        case .topMovie: return "Top Movies"
        case .tvSeries: return "Top TV Series"
        case .upcomingMovie: return "Upcoming Movies"
       
        }
    }
    
}

