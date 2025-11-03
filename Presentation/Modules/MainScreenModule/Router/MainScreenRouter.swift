//
//  MainScreenRouter.swift
//  MovieApp
//
//  Created by VladOS on 09.09.2025.
//

import UIKit

protocol MainScreenRouterProtocol: AnyObject {
    func showMoviePage(id: Int, title: String)
    func showMovieList(mode: MovieListMode)
    func showSettingsPage()
    func showTVSeriesPage(id: Int, title: String)
}

class MainScreenRouter: MainScreenRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func showMoviePage(id: Int, title: String) {
        let moviePageVC = Builder.createMoviePageController(id: id, title: title)
        
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
        let settingPageVC = Builder.createSettingsPageController()
        viewController?.present(settingPageVC, animated: true)
    }
    
    func showTVSeriesPage(id: Int, title: String) {
        let moviePageVC = Builder.createTVSeriesController(id: id, title: title)
        
        if let navigationVC = viewController?.navigationController {
            navigationVC.pushViewController(moviePageVC, animated: true)
        } else {
            viewController?.present(moviePageVC, animated: true)
        }
    }
    
}
