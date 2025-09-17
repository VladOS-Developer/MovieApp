//
//  ActorImages.swift
//  MovieApp
//
//  Created by VladOS on 17.09.2025.
//

import Foundation

struct ActorImages: Hashable {
    let filePath: String?
    let isLocalImage: Bool
}

extension ActorImages {
    init(dto: ActorImageDTO) {
        self.filePath = dto.filePath
        self.isLocalImage = false
    }
}

extension ActorImages {
    static func mockActorImages() -> [ActorImages] {
        return [
            ActorImages(filePath: "img12", isLocalImage: true),
            ActorImages(filePath: "img13", isLocalImage: true),
            ActorImages(filePath: "img14", isLocalImage: true),
        ]
    }
}
