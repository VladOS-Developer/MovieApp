//
//  MainScreenRouter.swift
//  MovieApp
//
//  Created by VladOS on 09.09.2025.
//

import UIKit

protocol MainScreenRouterProtocol: AnyObject {
    func showMoviePage(movieId: Int, movieTitle: String)
    func showMovieList(mode: MovieListMode)
    func showSettingsPage()
}

class MainScreenRouter: MainScreenRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func showMoviePage(movieId: Int, movieTitle: String) {
        let moviePageVC = Builder.createMoviePageController(movieId: movieId, movieTitle: movieTitle)
        
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
    
    func showSettingsPage() {
        let settingPageVC = Builder.SettingsPageController()
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(settingPageVC, animated: true)
        } else {
            viewController?.present(settingPageVC, animated: true)
        }
    }
    
}
