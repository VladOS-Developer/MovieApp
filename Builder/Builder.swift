//
//  Builder.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol BuilderProtocol {
    static func getPasscodeController(sceneDelegate: SceneDelegateProtocol) -> UIViewController
    
    static func createTabBarController() -> UIViewController
    static func createMainScreenController() -> UIViewController
    static func createTrailerPlayerController() -> UIViewController
    static func createFavoritesController() -> UIViewController
    
    static func createMovieListController(mode: MovieListMode) -> UIViewController //
    static func createMoviePageController(movieId: Int) -> UIViewController
}

class Builder: BuilderProtocol {
    
    static func getPasscodeController(sceneDelegate: SceneDelegateProtocol) -> UIViewController {
        
        let view = PasscodeView()
        let keychain = KeychainManager()
        let service = PasscodeService(keychainManager: keychain)
        let presenter = PasscodePresenter(view: view, service: service, sceneDelegate: sceneDelegate)
        
        view.passcodePresenter = presenter
        return view
    }
    
    static func createTabBarController() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarPresenter(view: tabBarView)
        
        tabBarView.presenter = presenter
        return tabBarView
    }
    
    static func createMainScreenController() -> UIViewController {
        let mainView = MainScreenView()
        let service: MovieServiceProtocol = MockMovieService.shared
        let presenter = MainScreenPresenter(view: mainView, service: service)
        
        mainView.presenter = presenter
        return UINavigationController(rootViewController: mainView)
    }
        
    static func createTrailerPlayerController() -> UIViewController {
        let playerView = TrailerPlayerView()
        let presenter = TrailerPlayerPresenter(view: playerView)
        
        playerView.presenter = presenter
//        return UINavigationController(rootViewController: playerView)
        return playerView
    }
    
    static func createFavoritesController() -> UIViewController {
        let favoritesView = FavoritesView()
        let presenter = FavoritesPresenter(view: favoritesView)
        
        favoritesView.presenter = presenter
//        return UINavigationController(rootViewController: favoritesView)
        return favoritesView
    }
    
    static func createMovieListController(mode: MovieListMode) -> UIViewController { //
        let listView = MovieListView()
        let service: MovieServiceProtocol = MockMovieService.shared
        let presenter = MovieListPresenter(view: listView, service: service, mode: mode)
    
        listView.presenter = presenter
        return listView
    }
    
    static func createMoviePageController(movieId: Int) -> UIViewController {
        let pageView = MoviePageView()
        let service: MovieServiceProtocol = MockMovieService.shared
        let presenter = MoviePagePresenter(view: pageView, service: service, movieId: movieId)
        
        pageView.presenter = presenter
        return pageView
    }
    
    
}
