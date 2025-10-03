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
    static func mockActorImages(for actorId: Int) -> [ActorImages] {

        switch actorId {
                case 6193: // Sam Worthington
                    return [
                        ActorImages(id: "1", filePath: "SamWorthington1", isLocalImage: true),
                        ActorImages(id: "2", filePath: "SamWorthington2", isLocalImage: true),
                        ActorImages(id: "3", filePath: "SamWorthington3", isLocalImage: true)
                    ]
                case 1234: // Zoe Saldana
                    return [
                        ActorImages(id: "4", filePath: "ZoeSaldana1", isLocalImage: true),
                        ActorImages(id: "5", filePath: "ZoeSaldana2", isLocalImage: true),
                        ActorImages(id: "6", filePath: "ZoeSaldana3", isLocalImage: true)
                    ]
                case 5678: // Sigourney Weaver
                    return [
                        ActorImages(id: "7", filePath: "SigourneyWeaver1", isLocalImage: true),
                        ActorImages(id: "8", filePath: "SigourneyWeaver2", isLocalImage: true),
                        ActorImages(id: "9", filePath: "SigourneyWeaver3", isLocalImage: true)
                    ]
                case 9012: // Stephen Lang
                    return [
                        ActorImages(id: "10", filePath: "StephenLang1", isLocalImage: true),
                        ActorImages(id: "11", filePath: "StephenLang2", isLocalImage: true),
                        ActorImages(id: "12", filePath: "StephenLang3", isLocalImage: true)
                    ]
                case 3456: // Giovanni Ribisi
                    return [
                        ActorImages(id: "13", filePath: "GiovanniRibisi1", isLocalImage: true),
                        ActorImages(id: "14", filePath: "GiovanniRibisi2", isLocalImage: true),
                        ActorImages(id: "15", filePath: "GiovanniRibisi3", isLocalImage: true)
                    ]
                default:
                    return [
                        ActorImages(id: "16", filePath: "img11", isLocalImage: true)
                    ]
                }
    }
}
