//
//  ActorPageRouter.swift
//  MovieApp
//
//  Created by VladOS on 26.09.2025.
//

import UIKit

protocol ActorPageRouterProtocol: AnyObject {
    func openMoviePage(movieId: Int, movieTitle: String)
}

final class ActorPageRouter: ActorPageRouterProtocol {
    weak var viewController: UIViewController?
    
    func openMoviePage(movieId: Int, movieTitle: String) {
        let moviePageVC = Builder.createMoviePageController(movieId: movieId, movieTitle: movieTitle)
        viewController?.navigationController?.pushViewController(moviePageVC, animated: true)
    }
}


