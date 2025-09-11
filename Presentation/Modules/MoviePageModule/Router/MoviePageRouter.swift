//
//  MoviePageRouter.swift
//  MovieApp
//
//  Created by VladOS on 31.08.2025.
//

import UIKit

protocol MoviePageRouterProtocol: AnyObject {
    func showTrailerPlayer(video: MovieVideo, movieTitle: String)
}

final class MoviePageRouter: MoviePageRouterProtocol {
    weak var viewController: UIViewController?

    func showTrailerPlayer(video: MovieVideo, movieTitle: String) {
        // Для теста UI с моками
        let trailerPlayerVC = Builder.createTrailerPlayerController(video: video, movieTitle: movieTitle, useMock: true)
        
        // Для реального API
//        let trailerPlayerVC = Builder.createTrailerPlayerController(video: MovieVideo.mockMovieVideo().first!, useMock: false)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(trailerPlayerVC, animated: true)
        } else {
            viewController?.present(trailerPlayerVC, animated: true)
        }
    }
    
}
