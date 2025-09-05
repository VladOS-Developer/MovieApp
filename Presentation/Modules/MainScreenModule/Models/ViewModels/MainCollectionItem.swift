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
        
    var id: Int {
        switch self {
        case .movie(let vm): return vm.id
        case .genre(let vm): return vm.id
        }
    }
    
    var title: String {
        switch self {
        case .movie(let vm): return vm.title
        case .genre(let vm): return vm.name
        }
    }

    var releaseDate: String? {
        switch self {
        case .movie(let vm): return vm.releaseDateText
        case .genre: return nil
        }
    }

    var genresText: String? {
        switch self {
        case .movie(let vm): return vm.genresText
        case .genre: return nil
        }
    }

    var posterImage: UIImage? {
        switch self {
        case .movie(let vm): return vm.posterImage
        case .genre: return nil
        }
    }

    var posterURL: URL? {
        switch self {
        case .movie(let vm): return vm.posterURL
        case .genre: return nil
        }
    }
}
