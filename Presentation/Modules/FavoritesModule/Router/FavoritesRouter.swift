//
//  FavoritesRouter.swift
//  MovieApp
//
//  Created by VladOS on 03.10.2025.
//

import UIKit

protocol FavoritesRouterProtocol: AnyObject {
    func openMoviePage(movieId: Int, movieTitle: String)
}

class FavoritesRouter: FavoritesRouterProtocol {
    weak var viewController: UIViewController?
    
    func openMoviePage(movieId: Int, movieTitle: String) {
        let moviePageVC = Builder.createMoviePageController(id: movieId, title: movieTitle)
        viewController?.navigationController?.pushViewController(moviePageVC, animated: true)
    }
}
