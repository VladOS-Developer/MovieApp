//
//  PageCollectionItem.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import UIKit

enum PageCollectionItem {
    
    case movieDet(PageDetailsCellViewModel)
    case genre(PageGenreCellViewModel)
    case video(PageVideoCellViewModel)
    case similarMovie(SimilarMovieCellViewModel)
    
    var id: String {
        switch self {
        case .movieDet(let vm): return String(vm.id)
        case .genre(let vm): return String(vm.id)
        case .video(let vm): return vm.id
        case .similarMovie(let vm): return String(vm.id)
        }
    }
    
    var title: String {
        switch self {
        case .movieDet(let vm): return vm.title
        case .genre(let vm): return vm.name
        case .video(let vm): return vm.name
        case .similarMovie(let vm): return vm.title
        }
    }
    
    var posterImage: UIImage? {
        switch self {
        case .movieDet(let vm): return vm.posterImage
        case .genre: return nil
        case .video(let vm): return vm.thumbnailImage
        case .similarMovie(let vm): return vm.posterImage
        }
    }
    
    var posterURL: URL? {
        switch self {
        case .movieDet(let vm): return vm.posterURL
        case .genre: return nil
        case .video(let vm): return vm.thumbnailURL
        case .similarMovie(let vm): return vm.posterURL
        }
    }
}
