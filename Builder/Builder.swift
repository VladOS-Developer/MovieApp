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
        
        let movieRepository: MovieDetailsRepositoryProtocol = MockMovieDetailsRepository.shared
        let genreRepository: GenreRepositoryProtocol = MockGenreRepository.shared
        
        let presenter = MainScreenPresenter(view: mainView, movieRepository: movieRepository, genreRepository: genreRepository)
        
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
        let movieRepository: MovieDetailsRepositoryProtocol = MockMovieDetailsRepository.shared
        let genreRepository: GenreRepositoryProtocol = MockGenreRepository.shared
        let presenter = MovieListPresenter(view: listView, movieRepository: movieRepository, genreRepository: genreRepository, mode: mode)
    
        listView.presenter = presenter
        return listView
    }
    
    static func createMoviePageController(movieId: Int) -> UIViewController {
        let pageView = MoviePageView()
        
        let movieDetailsRepository: MovieDetailsRepositoryProtocol = MockMovieDetailsRepository.shared
        let genreRepository: GenreRepositoryProtocol = MockGenreRepository.shared
        let movieVideoRepository: MovieVideoRepositoryProtocol = MockMovieVideoRepository.shared
        
        let presenter = MoviePagePresenter(view: pageView,
                                           movieDetailsRepository: movieDetailsRepository,
                                           genreRepository: genreRepository,
                                           movieVideoRepository: movieVideoRepository,
                                           movieId: movieId)
        
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
