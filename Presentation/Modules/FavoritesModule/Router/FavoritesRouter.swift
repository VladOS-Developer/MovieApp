//
//  FavoritesRouter.swift
//  MovieApp
//
//  Created by VladOS on 03.10.2025.
//

import UIKit

protocol FavoritesRouterProtocol: AnyObject {
    func openMoviePage(movieId: Int, movieTitle: String)
    func openTVPage(tvId: Int, tvTitle: String)
}

class FavoritesRouter: FavoritesRouterProtocol {
    weak var viewController: UIViewController?
    
    func openMoviePage(movieId: Int, movieTitle: String) {
        let moviePageVC = Builder.createMoviePageController(id: movieId, title: movieTitle)
        viewController?.navigationController?.pushViewController(moviePageVC, animated: true)
    }
    
    func openTVPage(tvId: Int, tvTitle: String) {
        let tvPageVC = Builder.createTVSeriesController(id: tvId, title: tvTitle)
        viewController?.navigationController?.pushViewController(tvPageVC, animated: true)
    }
}
