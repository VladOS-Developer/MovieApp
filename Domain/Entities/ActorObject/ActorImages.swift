//
//  ActorImages.swift
//  MovieApp
//
//  Created by VladOS on 17.09.2025.
//

import Foundation

struct ActorImages: Hashable {
    let id: String
    let filePath: String?
    let isLocalImage: Bool
}

extension ActorImages {
    init(dto: ActorImageDTO) {
        self.id = UUID().uuidString
        self.filePath = dto.filePath
        self.isLocalImage = false
    }
}

extension ActorImages {
    static func mockActorImages() -> [ActorImages] {
        return [
            ActorImages(id: "1", filePath: "img12", isLocalImage: true),
            ActorImages(id: "2", filePath: "img13", isLocalImage: true),
            ActorImages(id: "3", filePath: "img14", isLocalImage: true),
        ]
    }
}
