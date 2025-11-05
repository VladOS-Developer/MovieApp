//
//  TrailerListRouter.swift
//  MovieApp
//
//  Created by VladOS on 30.09.2025.
//

import UIKit

protocol TrailerListRouterProtocol: AnyObject {
    func showTrailerPlayer(video: MovieVideo, title: String, isMovie: Bool)
}

final class TrailerListRouter: TrailerListRouterProtocol {
    weak var viewController: UIViewController?
    
    func showTrailerPlayer(video: MovieVideo, title: String, isMovie: Bool) {
        
        let trailerPlayerVC = Builder.createTrailerPlayerController(video: video, movieTitle: title)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(trailerPlayerVC, animated: true)
        } else {
            viewController?.present(trailerPlayerVC, animated: true)
        }
    }
   
}
