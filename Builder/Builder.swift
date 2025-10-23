//
//  Builder.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol BuilderProtocol {
    static func getPasscodeController(sceneDelegate: SceneDelegateProtocol?, isSetting: Bool) -> UIViewController
    
    static func createTabBarController() -> UIViewController
    static func createMainScreenController() -> UIViewController
    static func createTrailerListController() -> UIViewController
    static func createFavoritesController() -> UIViewController
    
    static func createMovieListController(mode: MovieListMode) -> UIViewController
    static func createMoviePageController(movieId: Int, movieTitle: String) -> UIViewController
    static func createTrailerPlayerController(video: MovieVideo, movieTitle: String) -> UIViewController
    static func createActorPageController(actorTitle: String, actorId: Int) -> UIViewController
    static func createSettingsPageController() -> UIViewController
}

class Builder: BuilderProtocol {
    
    private static let useMock = false // false когда API ключ
    
    // Загрузка ключа из Info.plist
    private static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String else {
            fatalError("TMDB_API_KEY not found in Info.plist")
        }
        return key
    }
    
    //MARK: - Passcode
    static func getPasscodeController(sceneDelegate: SceneDelegateProtocol?, isSetting: Bool) -> UIViewController {
        
        let view = PasscodeView()
        let keychain = KeychainManager()
        let service = PasscodeService(keychainManager: keychain)
        let presenter = PasscodePresenter(view: view,
                                          service: service,
                                          sceneDelegate: sceneDelegate,
                                          isSetting: isSetting)
        
        view.passcodePresenter = presenter
        return view
    }
    
    //MARK: - TabBar
    static func createTabBarController() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarPresenter(view: tabBarView)
        
        tabBarView.presenter = presenter
        return tabBarView
    }
    
    //MARK: - MainScreen
    static func createMainScreenController() -> UIViewController {
        let mainView = MainScreenView()
        let router = MainScreenRouter()
        let imageLoader = KingfisherImageLoader()
 
        let movieRepository: MovieRepositoryProtocol = useMock
        ? MockMovieRepository.shared : MovieRepository(networkService: NetworkService(apiKey: apiKey))
        
        let genreRepository: GenreRepositoryProtocol = useMock
        ? MockGenreRepository.shared : GenreRepository(networkService: NetworkService(apiKey: apiKey))
        
        let presenter = MainScreenPresenter(view: mainView,
                                            router: router,
                                            movieRepository: movieRepository,
                                            genreRepository: genreRepository,
                                            imageLoader: imageLoader)
        
        mainView.presenter = presenter
        router.viewController = mainView
        return UINavigationController(rootViewController: mainView)
    }
     
    //MARK: - TrailerList
    static func createTrailerListController() -> UIViewController {
        let trailerListView = TrailerListView()
        let router = TrailerListRouter()
        
        let movieVideoRepository: MovieVideoRepositoryProtocol = useMock
        ? MockMovieVideoRepository.shared : MovieVideoRepository(networkService: NetworkService(apiKey: apiKey))
        
        let presenter = TrailerListPresenter(view: trailerListView,
                                             router: router,
                                             movieVideoRepository: movieVideoRepository)
        
        
        trailerListView.presenter = presenter
        router.viewController = trailerListView
        return UINavigationController(rootViewController: trailerListView)
    }
    
    //MARK: - Favorites
    static func createFavoritesController() -> UIViewController {
        let favoritesView = FavoritesView()
        let router = FavoritesRouter()
        let imageLoader = KingfisherImageLoader()
        
        let presenter = FavoritesPresenter(view: favoritesView,
                                           router: router,
                                           imageLoader: imageLoader)
        
        favoritesView.presenter = presenter
        router.viewController = favoritesView
        return UINavigationController(rootViewController: favoritesView)
    }
    
    //MARK: - MovieList
    static func createMovieListController(mode: MovieListMode) -> UIViewController {
        let listView = MovieListView()
        let imageLoader = KingfisherImageLoader()
        
        let movieRepository: MovieRepositoryProtocol = useMock
        ? MockMovieRepository.shared : MovieRepository(networkService: NetworkService(apiKey: apiKey))
        
        let genreRepository: GenreRepositoryProtocol = useMock
        ? MockGenreRepository.shared : GenreRepository(networkService: NetworkService(apiKey: apiKey))
        
        let presenter = MovieListPresenter(view: listView,
                                           movieRepository: movieRepository,
                                           genreRepository: genreRepository,
                                           imageLoader: imageLoader,
                                           mode: mode)
    
        listView.presenter = presenter
        return listView
    }
    
    //MARK: - MoviePage
    static func createMoviePageController(movieId: Int, movieTitle: String) -> UIViewController {
        let pageView = MoviePageView()
        let router = MoviePageRouter()
        let imageLoader = KingfisherImageLoader()
        
        let movieDetailsRepository: MovieDetailsRepositoryProtocol = useMock
        ? MockMovieDetailsRepository.shared : MovieDetailsRepository(networkService: NetworkService(apiKey: apiKey))
        
        let genreRepository: GenreRepositoryProtocol = useMock
        ? MockGenreRepository.shared : GenreRepository(networkService: NetworkService(apiKey: apiKey))
        
        let movieVideoRepository: MovieVideoRepositoryProtocol = useMock
        ? MockMovieVideoRepository.shared : MovieVideoRepository(networkService: NetworkService(apiKey: apiKey))
        
        let movieSimilarRepository: MovieSimilarRepositoryProtocol = useMock
        ? MockMovieSimilarRepository.shared : MovieSimilarRepository(networkService: NetworkService(apiKey: apiKey))
        
        let movieCreditsRepository: MovieCreditsRepositoryProtocol = useMock
        ? MockMovieCreditsRepository.shared : MovieCreditsRepository(networkService: NetworkService(apiKey: apiKey))
        
        let presenter = MoviePagePresenter(view: pageView,
                                           router: router,
                                           imageLoader: imageLoader,
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
    
    //MARK: - TrailerPlayer
    static func createTrailerPlayerController(video: MovieVideo, movieTitle: String) -> UIViewController {
        let playerView = TrailerPlayerView()
        
        let movieVideoRepository: MovieVideoRepositoryProtocol = useMock
        ? MockMovieVideoRepository.shared : MovieVideoRepository(networkService: NetworkService(apiKey: apiKey))
        
        let presenter = TrailerPlayerPresenter(view: playerView,
                                               movieVideoRepository: movieVideoRepository,
                                               video: video,
                                               movieTitle: movieTitle)
     
        playerView.presenter = presenter
        return playerView
    }
    
    //MARK: - ActorPage
    static func createActorPageController(actorTitle: String, actorId: Int) -> UIViewController {
        let actorView = ActorPageView()
        let router = ActorPageRouter()
                
        let actorRepository: ActorRepositoryProtocol = useMock
        ? MockActorRepository.shared : ActorRepository(networkService: NetworkService(apiKey: apiKey))
        
        let movieCreditsRepository: MovieCreditsRepositoryProtocol = useMock
        ? MockMovieCreditsRepository.shared : MovieCreditsRepository(networkService: NetworkService(apiKey: apiKey))
        
        let presenter = ActorPagePresenter(view: actorView,
                                           router: router,
                                           actorRepository: actorRepository,
                                           movieCreditsRepository: movieCreditsRepository,
                                           actorId: actorId,
                                           actorTitle: actorTitle)
        
        actorView.presenter = presenter
        router.viewController = actorView
        return actorView
    }
    
    //MARK: - SettingPage
    static func createSettingsPageController() -> UIViewController {
        let settingView = SettingsPageView()
        let keychain = KeychainManager()
        let service = PasscodeService(keychainManager: keychain)
        
        let presenter = SettingsPagePresenter(view: settingView, service: service)
    
        settingView.presenter = presenter
        return UINavigationController(rootViewController: settingView)
    }
    
    
}
