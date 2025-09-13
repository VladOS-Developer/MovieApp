//
//  PageCollectionItem.swift
//  MovieApp
//
//  Created by VladOS on 27.08.2025.
//

import UIKit

enum PageCollectionItem: Hashable {
    
    case movieDet(DetailsCellViewModel)
    case genre(GenreCellViewModel)
    case video(VideoCellViewModel)
    case similarMovie(SimilarMovieCellViewModel)
    case actor(ActorCellViewModel)
    case actorMovie(ActorMovieCellViewModel)
    case cast(CastCellViewModel)
    case crew(CrewCellViewModel)
 
    var id: String {
        switch self {
        case .movieDet(let vm): return String(vm.id)
        case .genre(let vm): return String(vm.id)
        case .video(let vm): return vm.id
        case .similarMovie(let vm): return String(vm.id)
        case .actor(let vm): return String(vm.id)
        case .actorMovie(let vm): return String(vm.id)
        case .cast(let vm): return String(vm.id)            // "cast_\(vm.id)"
        case .crew(let vm): return String(vm.id)            // "crew_\(vm.id)"
        }
    }
    
    var title: String {
        switch self {
        case .movieDet(let vm): return vm.title
        case .genre(let vm): return vm.name
        case .video(let vm): return vm.name
        case .similarMovie(let vm): return vm.title
        case .actor(let vm): return vm.name
        case .actorMovie(let vm): return vm.title
        case .cast(let vm): return vm.name
        case .crew(let vm): return vm.name
        }
    }
    
    var posterImage: UIImage? {
        switch self {
        case .movieDet(let vm): return vm.posterImage
        case .genre: return nil
        case .video(let vm): return vm.thumbnailImage
        case .similarMovie(let vm): return vm.posterImage
        case .actor(let vm): return vm.profileImage
        case .actorMovie(let vm): return vm.posterImage
        case .cast(let vm): return vm.profileImage
        case .crew(let vm): return vm.profileImage
        }
    }
    
    var posterURL: URL? {
        switch self {
        case .movieDet(let vm): return vm.posterURL
        case .genre: return nil
        case .video(let vm): return vm.thumbnailURL
        case .similarMovie(let vm): return vm.posterURL
        case .actor(let vm): return vm.profileURL
        case .actorMovie(let vm): return vm.posterURL
        case .cast(let vm): return vm.profileURL
        case .crew(let vm): return vm.profileURL
        }
    }
}
