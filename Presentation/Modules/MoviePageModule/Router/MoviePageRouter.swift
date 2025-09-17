//
//  MoviePageRouter.swift
//  MovieApp
//
//  Created by VladOS on 31.08.2025.
//

import UIKit

protocol MoviePageRouterProtocol: AnyObject {
    func showTrailerPlayer(video: MovieVideo, movieTitle: String)
    func showActorPage(actorName: String, actorId: Int)
}

final class MoviePageRouter: MoviePageRouterProtocol {
    weak var viewController: UIViewController?
    
    func showTrailerPlayer(video: MovieVideo, movieTitle: String) {
        // Для теста UI с моками
        let trailerPlayerVC = Builder.createTrailerPlayerController(video: video, movieTitle: movieTitle)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(trailerPlayerVC, animated: true)
        } else {
            viewController?.present(trailerPlayerVC, animated: true)
        }
    }
    
    func showActorPage(actorName: String, actorId: Int) {
        let vc = Builder.createActorPageController(actorTitle: actorName, actorId: actorId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
