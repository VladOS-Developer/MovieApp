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
        let presenter = MainScreenPresenter(view: mainView)
        
        mainView.presenter = presenter
        return mainView
    }
    
    static func createFavoritesController() -> UIViewController {
        let favoritesView = FavoritesView()
        let presenter = FavoritesPresenter(view: favoritesView)
        
        favoritesView.presenter = presenter
        return favoritesView
    }
    
    static func createTrailerPlayerController() -> UIViewController {
        let playerView = TrailerPlayerView()
        let presenter = TrailerPlayerPresenter(view: playerView)
        
        playerView.presenter = presenter
        return playerView
    }
    
}
