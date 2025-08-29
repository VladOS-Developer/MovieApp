//
//  PageCollectionItem.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import UIKit

enum PageCollectionItem {
    
    case movie(PageDetailsCellViewModel)
    case genre(PageGenreCellViewModel)
    case video(PageVideoCellViewModel)
    
    var id: String {
        switch self {
        case .movie(let vm): return String(vm.id)
        case .genre(let vm): return String(vm.id)
        case .video(let vm): return vm.id
        }
    }
    
    var title: String {
        switch self {
        case .movie(let vm): return vm.title
        case .genre(let vm): return vm.name
        case .video(let vm): return vm.name
        }
    }
    
    var posterImage: UIImage? {
        switch self {
        case .movie(let vm): return vm.posterImage
        case .genre: return nil
        case .video(let vm): return vm.thumbnailImage
        }
    }
    
    var posterURL: URL? {
        switch self {
        case .movie(let vm): return vm.posterURL
        case .genre: return nil
        case .video(let vm): return vm.thumbnailURL
        }
    }
}
