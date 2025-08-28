//
//  PageVideoCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 28.08.2025.
//

import UIKit

struct PageVideoCellViewModel: Hashable {
    let id: String
    let videoKey: String
    let name: String
    let type: String
    
    let thumbnailImage: UIImage? // для моков
    let thumbnailURL: URL?       // для API
    
    init(video: MovieVideo, isLocal: Bool = false) {
        self.id = video.id
        self.name = video.name
        self.videoKey = video.key
        self.type = video.type
        
        if isLocal {
            self.thumbnailImage = UIImage(named: video.key) // мок из ассетов
            self.thumbnailURL = nil
        } else {
            self.thumbnailImage = nil
            self.thumbnailURL = URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
        }
    }
}
