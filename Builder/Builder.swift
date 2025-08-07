//
//  Builder.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol BuilderProtocol {
    static func getPasscodeController(sceneDelegate: SceneDelegateProtocol) -> UIViewController
    static func createTabBarControllers() -> UIViewController
    
    static func createMainScreenControllers() -> UIViewController
    static func createTrailerPlayerControllers() -> UIViewController
    static func createDynamicControllers() -> UIViewController
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
    
    static func createTabBarControllers() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarPresenter(view: tabBarView)
        
        tabBarView.presenter = presenter
        return tabBarView
    }
    
    static func createMainScreenControllers() -> UIViewController {
        let mainView = MainScreenView()
        let presenter = MainScreenPresenter(view: mainView)
        
        mainView.presenter = presenter
        return mainView
    }
    
    static func createTrailerPlayerControllers() -> UIViewController {
        let playerView = TrailerPlayerView()
        let presenter = TrailerPlayerPresenter(view: playerView)
        
        playerView.presenter = presenter
        return playerView
    }
    
    static func createDynamicControllers() -> UIViewController {
        let dynamicView = DynamicView()
        let presenter = DynamicPresenter(view: dynamicView)
        
        dynamicView.presenter = presenter
        return dynamicView
    }
    
}
