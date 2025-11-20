//
//  MovieListRouter.swift
//  MovieApp
//
//  Created by VladOS on 19.11.2025.
//

import UIKit

protocol MovieListRouterProtocol: AnyObject {
    func showMoviePage(movieId: Int, movieTitle: String)
    func showTVSeriesPage(seriesId: Int, seriesTitle: String)
}

final class MovieListRouter: MovieListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func showMoviePage(movieId: Int, movieTitle: String) {
        let movieVC = Builder.createMoviePageController(id: movieId, title: movieTitle)
        viewController?.navigationController?.pushViewController(movieVC, animated: true)
    }
    
    func showTVSeriesPage(seriesId: Int, seriesTitle: String) {
        let seriesVC = Builder.createTVSeriesController(id: seriesId, title: seriesTitle)
        viewController?.navigationController?.pushViewController(seriesVC, animated: true)
    }
}
