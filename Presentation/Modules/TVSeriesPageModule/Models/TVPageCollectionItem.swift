//
//  TVPageCollectionItem.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

enum TVPageCollectionItem: Hashable {
    
    case tvDetails(TVDetailsCellViewModel)
    case tvGenre(TVGenreCellViewModel)
    case tvVideo(TVVideoCellViewModel)
    case tvSimilar(TVSimilarCellViewModel)
    case tvCast(TVCastCellViewModel)
    
    var id: String {
        switch self {
        case .tvDetails(let vm): return String(vm.id)
        case .tvGenre(let vm): return String(vm.id)
        case .tvVideo(let vm): return String(vm.id)
        case .tvSimilar(let vm): return String(vm.id)
//        case .cast(let vm): return String(vm.id)            // "cast_\(vm.id)" чтобы избежать коллизий идентификаторов
        case .tvCast(let vm): return "cast_\(vm.id)"
        }
    }
    
    var title: String {
        switch self {
        case .tvDetails(let vm): return vm.title
        case .tvGenre(let vm): return vm.name
        case .tvVideo(let vm): return vm.name
        case .tvSimilar(let vm): return vm.title
        case .tvCast(let vm): return vm.name
        }
    }
    
    var posterImage: UIImage? {
        switch self {
        case .tvDetails(let vm): return vm.posterImage
        case .tvGenre: return nil
        case .tvVideo(let vm): return vm.thumbnailImage
        case .tvSimilar(let vm): return vm.posterImage
        case .tvCast(let vm): return vm.profileImage
        }
    }
    
    var posterURL: URL? {
        switch self {
        case .tvDetails(let vm): return vm.posterURL
        case .tvGenre: return nil
        case .tvVideo(let vm): return vm.thumbnailURL
        case .tvSimilar(let vm): return vm.posterURL
        case .tvCast(let vm): return vm.profileURL
        }
    }
}
