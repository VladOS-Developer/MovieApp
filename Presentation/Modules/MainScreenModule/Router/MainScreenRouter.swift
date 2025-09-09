//
//  MainScreenRouter.swift
//  MovieApp
//
//  Created by VladOS on 09.09.2025.
//

import UIKit

protocol MainScreenRouterProtocol: AnyObject {
    func showMoviePage(movieId: Int)
    func showMovieList(mode: MovieListMode)
}

class MainScreenRouter: MainScreenRouterProtocol {
    weak var viewController: UIViewController?
    
    func showMoviePage(movieId: Int) {
        let moviePageVC = Builder.createMoviePageController(movieId: movieId)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(moviePageVC, animated: true)
        } else {
            viewController?.present(moviePageVC, animated: true)
        }
    }
    
    func showMovieList(mode: MovieListMode) {
        let movieListVC = Builder.createMovieListController(mode: mode)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(movieListVC, animated: true)
        } else {
            viewController?.present(movieListVC, animated: true)
        }
    }
    
    
}
