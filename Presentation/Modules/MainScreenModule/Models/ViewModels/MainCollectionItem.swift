//
//  MainCollectionItem.swift
//  MovieApp
//
//  Created by VladOS on 08.08.2025.
//

import UIKit

enum MainCollectionItem {
    case genre(GenreCellViewModel)
    case movie(MovieCellViewModel)
    case searchHeaderItem
        
    var id: Int {
        switch self {
        case .movie(let vm): return vm.id
        case .genre(let vm): return vm.id
        case .searchHeaderItem: return -1
            
        }
    }
    
    var title: String {
        switch self {
        case .movie(let vm): return vm.title
        case .genre(let vm): return vm.name
        case .searchHeaderItem: return "Search"
        }
    }

    var releaseDate: String? {
        switch self {
        case .movie(let vm): return vm.releaseDateText
        case .genre: return nil
        case .searchHeaderItem: return nil
        }
    }

    var genresText: String? {
        switch self {
        case .movie(let vm): return vm.genresText
        case .genre: return nil
        case .searchHeaderItem: return nil
        }
    }

    var posterImage: UIImage? {
        switch self {
        case .movie(let vm): return vm.posterImage
        case .genre: return nil
        case .searchHeaderItem: return nil
            
        }
    }

    var posterURL: URL? {
        switch self {
        case .movie(let vm): return vm.posterURL
        case .genre: return nil
        case .searchHeaderItem: return nil
        }
    }
}
