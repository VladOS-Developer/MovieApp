//
//  MovieListMode.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import Foundation

enum MovieListMode {
    case genre(id: Int, title: String)
    case top10
    case upcoming
    case tvSeries

    var title: String {
        switch self {
        case .genre(_, let title): return title
        case .top10: return "Top Movies"
        case .upcoming: return "Upcoming Movies"
        case .tvSeries: return "Top TV Series"
        }
    }
}
