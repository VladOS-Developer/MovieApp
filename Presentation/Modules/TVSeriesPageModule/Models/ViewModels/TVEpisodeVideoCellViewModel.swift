//
//  TVEpisodeVideoCellViewModel.swift
//  MovieApp
//
//  Created by VladOS on 07.11.2025.
//

import UIKit

struct TVEpisodeVideoCellViewModel: Hashable {
    let id: String
    let videoKey: String
    let name: String
    let site: String
    let type: String

    var thumbnailImage: UIImage?
    var thumbnailURL: URL?

    init(video: TVEpisodeVideo, isLocal: Bool = true) {
        self.id = video.id
        self.videoKey = video.key
        self.name = video.name
        self.site = video.site
        self.type = video.type

        if isLocal {
            // локальные превью в ассетах
            self.thumbnailImage = UIImage(named: video.key)
            self.thumbnailURL = nil
        } else {
            // превью с YouTube
            self.thumbnailImage = nil
            self.thumbnailURL = URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
        }
    }
}
