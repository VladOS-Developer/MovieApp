//
//  Builder.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol BuilderProtocol {
    static func getPasscodeController() -> UIViewController
    static func createTabBarControllers() -> UIViewController
}

class Builder: BuilderProtocol {
    
    static func getPasscodeController() -> UIViewController {
        let view = PasscodeView()
        let keychain = KeychainManager()
        let service = PasscodeService(keychainManager: keychain)
        let presenter = PasscodePresenter(view: view, service: service)
        
        view.passcodePresenter = presenter
        return view
    }
    
    static func createTabBarControllers() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarPresenter(view: tabBarView)
        
        tabBarView.presenter = presenter
        return tabBarView
    }
    
}
