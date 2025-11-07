//
//  TVEpisodeCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 07.11.2025.
//

import UIKit

//struct TVEpisodeCellViewModel: Hashable {
//    let id: Int
//    let title: String
//    let episodeNumber: Int
//    let airDate: String?
//    let runtime: Int?
//    let overview: String?
//
//    var thumbnailImage: UIImage?   // мок
//    var thumbnailURL: URL?         // API
//
//    var videos: [TVEpisodeVideoCellViewModel] // трейлеры/видео эпизода
//
//    init(episode: TVEpisode, isLocal: Bool = true) {
//        self.id = episode.id
//        self.title = episode.name
//        self.episodeNumber = episode.episodeNumber
//        self.airDate = episode.airDate
//        self.runtime = episode.runtime
//        self.overview = episode.overview
//
//        // videos -> viewmodels
//        self.videos = episode.videos.map { TVEpisodeVideoCellViewModel(video: $0, isLocal: isLocal) }
//
//        // still path -> url / local image
//        if isLocal {
//            // если в stillPath "/got_ep1.jpg", попробуем убрать ведущий "/" и взять имя ассета "got_ep1.jpg" или "got_ep1"
//            if let path = episode.stillPath {
//                let trimmed = path.hasPrefix("/") ? String(path.dropFirst()) : path
//                // пробуем сначала имя без расширения
//                let nameNoExt = (trimmed as NSString).deletingPathExtension
//                self.thumbnailImage = UIImage(named: nameNoExt) ?? UIImage(named: trimmed)
//            } else {
//                self.thumbnailImage = nil
//            }
//            self.thumbnailURL = nil
//        } else {
//            self.thumbnailImage = nil
//            if let path = episode.stillPath {
//                let urlString = "https://image.tmdb.org/t/p/w500\(path)"
//                self.thumbnailURL = URL(string: urlString)
//            } else {
//                self.thumbnailURL = nil
//            }
//        }
//    }
//}
struct TVEpisodeCellViewModel: Hashable {
    let id: Int
    let title: String
    let episodeNumber: Int
    let airDate: String?
    let runtime: Int?
    let overview: String?

    var thumbnailImage: UIImage?
    var thumbnailURL: URL?
    var videos: [TVEpisodeVideoCellViewModel]

    init(episode: TVEpisode, isLocal: Bool = true) {
        self.id = episode.id
        self.title = episode.name
        self.episodeNumber = episode.episodeNumber
        self.airDate = episode.airDate
        self.runtime = episode.runtime
        self.overview = episode.overview
        self.videos = episode.videos.map { TVEpisodeVideoCellViewModel(video: $0, isLocal: isLocal) }

        if isLocal {
            if let path = episode.stillPath {
                let trimmed = path.hasPrefix("/") ? String(path.dropFirst()) : path
                let nameNoExt = (trimmed as NSString).deletingPathExtension
                self.thumbnailImage = UIImage(named: nameNoExt) ?? UIImage(named: trimmed)
            } else {
                self.thumbnailImage = nil
            }
            self.thumbnailURL = nil
        } else {
            if let path = episode.stillPath {
                let urlString = "https://image.tmdb.org/t/p/w500\(path)"
                self.thumbnailURL = URL(string: urlString)
            } else {
                self.thumbnailURL = nil
            }
            self.thumbnailImage = nil
        }
    }
}

