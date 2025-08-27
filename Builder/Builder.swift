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
    static func createTrailerListController() -> UIViewController
    static func createFavoritesController() -> UIViewController
    
    static func createMovieListController(mode: MovieListMode) -> UIViewController
    static func createMoviePageController(movieId: Int) -> UIViewController
    static func createTrailerPlayerController() -> UIViewController
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
        let repository: MovieRepositoryProtocol = MockMovieRepository.shared
        let presenter = MainScreenPresenter(view: mainView, repository: repository)
        
        mainView.presenter = presenter
        return UINavigationController(rootViewController: mainView)
    }
        
    static func createTrailerListController() -> UIViewController {
        let trailerListView = TrailerListView()
        let presenter = TrailerListPresenter(view: trailerListView)
        
        trailerListView.presenter = presenter
        return UINavigationController(rootViewController: trailerListView)
    }
    
    static func createFavoritesController() -> UIViewController {
        let favoritesView = FavoritesView()
        let presenter = FavoritesPresenter(view: favoritesView)
        
        favoritesView.presenter = presenter
        return UINavigationController(rootViewController: favoritesView)
    }
    
    static func createMovieListController(mode: MovieListMode) -> UIViewController {
        let listView = MovieListView()
        let repository: MovieRepositoryProtocol = MockMovieRepository.shared
        let presenter = MovieListPresenter(view: listView, repository: repository, mode: mode)
    
        listView.presenter = presenter
        return listView
    }
    
    static func createMoviePageController(movieId: Int) -> UIViewController {
        let pageView = MoviePageView()
        let repository: MovieRepositoryProtocol = MockMovieRepository.shared
        let presenter = MoviePagePresenter(view: pageView, repository: repository, movieId: movieId)
        
        pageView.presenter = presenter
        return pageView
    }
    
    static func createTrailerPlayerController() -> UIViewController {
        let playerView = TrailerPlayerView()
        let presenter = TrailerPlayerPresenter(view: playerView)
        
        playerView.presenter = presenter
        return playerView
    }
    
    
}
