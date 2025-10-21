//
//  KingfisherImageLoader.swift
//  MovieApp
//
//  Created by VladOS on 20.10.2025.
//

import UIKit
import Kingfisher

protocol ImageLoaderProtocol {
    func loadImage(from url: URL?, localName: String?, isLocal: Bool) async -> UIImage?
}

final class KingfisherImageLoader: ImageLoaderProtocol {
    
    func loadImage(from url: URL?, localName: String?, isLocal: Bool) async -> UIImage? {
        // Если это локальный мок — грузим ассет из Assets
        if isLocal {
            guard let localName, let image = UIImage(named: localName) else { return nil }
            return image
        }
        
        // Если это API — грузим из сети через Kingfisher
        guard let url else { return nil }
        
        return await withCheckedContinuation { continuation in
            
            let resource = KF.ImageResource(downloadURL: url)
            
            KingfisherManager.shared.retrieveImage(with: resource) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value.image)
                case .failure:
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}

