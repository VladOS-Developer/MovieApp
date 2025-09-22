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
    static func createMoviePageController(movieId: Int, movieTitle: String) -> UIViewController
    static func createTrailerPlayerController(video: MovieVideo, movieTitle: String) -> UIViewController
    static func createActorPageController(actorTitle: String, actorId: Int) -> UIViewController
}

class Builder: BuilderProtocol {
    
    private static let useMock = true // false когда API ключ
    private static let apiKey = "key"
   
    static func getPasscodeController(sceneDelegate: SceneDelegateProtocol) -> UIViewController {
        
        let view = PasscodeView()
        let keychain = KeychainManager()
        let service = PasscodeService(keychainManager: keychain)
        let presenter = PasscodePresenter(view: view,
                                          service: service,
                                          sceneDelegate: sceneDelegate)
        
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
        let router = MainScreenRouter()
        
//        let movieRepository: MovieRepositoryProtocol = MockMovieRepository.shared
//        let genreRepository: GenreRepositoryProtocol = MockGenreRepository.shared
        let movieRepository: MovieRepositoryProtocol = useMock
                    ? MockMovieRepository.shared
                    : MovieRepository(networkService: NetworkService(apiKey: apiKey))

                let genreRepository: GenreRepositoryProtocol = useMock
                    ? MockGenreRepository.shared
                    : GenreRepository(networkService: NetworkService(apiKey: apiKey))
        
        let presenter = MainScreenPresenter(view: mainView,
                                            router: router,
                                            movieRepository: movieRepository,
                                            genreRepository: genreRepository)
        
        mainView.presenter = presenter
        router.viewController = mainView
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
        let movieRepository: MovieRepositoryProtocol = MockMovieRepository.shared
        let genreRepository: GenreRepositoryProtocol = MockGenreRepository.shared
        
        let presenter = MovieListPresenter(view: listView,
                                           movieRepository: movieRepository,
                                           genreRepository: genreRepository,
                                           mode: mode)
    
        listView.presenter = presenter
        return listView
    }
    
    static func createMoviePageController(movieId: Int, movieTitle: String) -> UIViewController {
        let pageView = MoviePageView()
        let router = MoviePageRouter()
        
        let movieDetailsRepository: MovieDetailsRepositoryProtocol = MockMovieDetailsRepository.shared
        let genreRepository: GenreRepositoryProtocol = MockGenreRepository.shared
        let movieVideoRepository: MovieVideoRepositoryProtocol = MockMovieVideoRepository.shared
        let movieSimilarRepository: MovieSimilarRepositoryProtocol = MockMovieSimilarRepository.shared
        let movieCreditsRepository: MovieCreditsRepositoryProtocol = MockMovieCreditsRepository.shared
        
        let presenter = MoviePagePresenter(view: pageView,
                                           router: router,
                                           movieDetailsRepository: movieDetailsRepository,
                                           genreRepository: genreRepository,
                                           movieVideoRepository: movieVideoRepository,
                                           movieSimilarRepository: movieSimilarRepository,
                                           movieCreditsRepository: movieCreditsRepository,
                                           movieTitle: movieTitle,
                                           movieId: movieId)
        
        pageView.presenter = presenter
        router.viewController = pageView
        return pageView
    }
    
    static func createTrailerPlayerController(video: MovieVideo, movieTitle: String) -> UIViewController {
        let playerView = TrailerPlayerView()
        
        let movieVideoRepository: MovieVideoRepositoryProtocol = MockMovieVideoRepository.shared
        
        let presenter = TrailerPlayerPresenter(view: playerView,
                                               movieVideoRepository: movieVideoRepository,
                                               video: video,
                                               movieTitle: movieTitle)
     
        playerView.presenter = presenter
        return playerView
    }
    
    static func createActorPageController(actorTitle: String, actorId: Int) -> UIViewController {
        let ActorView = ActorPageView()
        
        let actorRepository: ActorRepositoryProtocol = MockActorRepository.shared
        let movieCreditsRepository: MovieCreditsRepositoryProtocol = MockMovieCreditsRepository.shared
        
        let presenter = ActorPagePresenter(view: ActorView,
                                           actorRepository: actorRepository,
                                           movieCreditsRepository: movieCreditsRepository,
                                           actorId: actorId,
                                           actorTitle: actorTitle)
        
        ActorView.presenter = presenter
        return ActorView
    }
    
    
}
