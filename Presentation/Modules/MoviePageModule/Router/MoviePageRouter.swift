//
//  MoviePageRouter.swift
//  MovieApp
//
//  Created by VladOS on 31.08.2025.
//

import UIKit

protocol MoviePageRouterProtocol: AnyObject {
    func showTrailerPlayer()
}

final class MoviePageRouter: MoviePageRouterProtocol {
    weak var viewController: UIViewController?

    func showTrailerPlayer() {
        let trailerPlayerVC = Builder.createTrailerPlayerController()
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(trailerPlayerVC, animated: true)
        } else {
            viewController?.present(trailerPlayerVC, animated: true)
        }
    }
    
}
