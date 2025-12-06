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
    case TMDBHeaderItem
    case tvSeries(TVSeriesCellViewModel)
        
    var id: Int {
        switch self {
        case .movie(let vm): return vm.id
        case .genre(let vm): return vm.id
        case .searchHeaderItem: return -1
        case .TMDBHeaderItem: return -1
        case .tvSeries(let vm): return vm.id
        }
    }
    
    var title: String {
        switch self {
        case .movie(let vm): return vm.title
        case .genre(let vm): return vm.name
        case .searchHeaderItem: return "Search"
        case .TMDBHeaderItem: return "TMDB"
        case .tvSeries(let vm): return vm.title
        }
    }

    var releaseDate: String? {
        switch self {
        case .movie(let vm): return vm.releaseDateText
        case .genre: return nil
        case .searchHeaderItem: return nil
        case .TMDBHeaderItem: return nil
        case .tvSeries(let vm): return vm.releaseDateText
        }
    }

    var genresText: String? {
        switch self {
        case .movie(let vm): return vm.genresText
        case .genre: return nil
        case .searchHeaderItem: return nil
        case .TMDBHeaderItem: return nil
        case .tvSeries(let vm): return vm.genresText
        }
    }

    var posterImage: UIImage? {
        switch self {
        case .movie(let vm): return vm.posterImage
        case .genre: return nil
        case .searchHeaderItem: return nil
        case .TMDBHeaderItem: return nil
        case .tvSeries(let vm): return vm.posterImage
        }
    }

    var posterURL: URL? {
        switch self {
        case .movie(let vm): return vm.posterURL
        case .genre: return nil
        case .searchHeaderItem: return nil
        case .TMDBHeaderItem: return nil
        case .tvSeries(let vm): return vm.posterURL
        }
    }
}
