//
//  TrailerPlayerCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 01.10.2025.
//

import UIKit

struct TrailerPlayerCellViewModel: Hashable {
    let id: String
    let videoKey: String    // для запуска YouTube-видео
    let name: String        // название трейлера
    let site: String        // обычно "YouTube"
    let type: String        // Trailer / Teaser / Clip
    
    var thumbnailImage: UIImage? // для моков
    var thumbnailURL: URL?       // для API
    
    init(video: MovieVideo, isLocal: Bool = true) {
        self.id = video.id
        self.videoKey = video.key
        self.name = video.name
        self.site = video.site
        self.type = video.type
        
        if isLocal {
            self.thumbnailImage = UIImage(named: video.key) // мок из ассетов
            self.thumbnailURL = nil
        } else {
            self.thumbnailImage = nil
            self.thumbnailURL = URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
        }
    }
    
    init(video: TVVideo, isLocal: Bool = true) {
        self.id = video.id
        self.videoKey = video.key
        self.name = video.name
        self.site = video.site
        self.type = video.type
        
        if isLocal {
            self.thumbnailImage = UIImage(named: video.key)
            self.thumbnailURL = nil
        } else {
            self.thumbnailImage = nil
            self.thumbnailURL = URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
        }
    }
    
    init(video: TVEpisodeVideo, isLocal: Bool = true) {
        self.id = video.id
        self.videoKey = video.key
        self.name = video.name
        self.site = video.site
        self.type = video.type
        
        if isLocal {
            self.thumbnailImage = UIImage(named: video.key)
            self.thumbnailURL = nil
        } else {
            self.thumbnailImage = nil
            self.thumbnailURL = URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
        }
    }
}
