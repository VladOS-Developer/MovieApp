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
    func showMoviePage(movieId: Int, movieTitle: String)
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
        let actorPageVC = Builder.createActorPageController(actorTitle: actorName, actorId: actorId)
        viewController?.navigationController?.pushViewController(actorPageVC, animated: true)
    }
    
    func showMoviePage(movieId: Int, movieTitle: String) {
        let moviePageVC = Builder.createMoviePageController(movieId: movieId,movieTitle: movieTitle)
        viewController?.navigationController?.pushViewController(moviePageVC, animated: true)
    }
    
    
}
