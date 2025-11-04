//
//  VideoType.swift
//  MovieApp
//
//  Created by VladOS on 04.11.2025.
//

import Foundation

enum VideoType {
    case movie(MovieVideo)
    case tv(TVVideo)
    
    var id: String {
        switch self {
        case .movie(let v): return v.id
        case .tv(let v): return v.id
        }
    }
    
    var key: String {
        switch self {
        case .movie(let v): return v.key
        case .tv(let v): return v.key
        }
    }
    
    var name: String {
        switch self {
        case .movie(let v): return v.name
        case .tv(let v): return v.name
        }
    }
    
    var site: String {
        switch self {
        case .movie(let v): return v.site
        case .tv(let v): return v.site
        }
    }
    
    var type: String {
        switch self {
        case .movie(let v): return v.type
        case .tv(let v): return v.type
        }
    }
}
