//
//  TVVideoCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

struct TVVideoCellViewModel: Hashable {
    let id: String
    let videoKey: String
    let name: String
    let site: String
    let type: String
    
    var thumbnailImage: UIImage? // для моков
    var thumbnailURL: URL?       // для API
    
    init(video: TVVideo, isLocal: Bool = true) {
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
}
