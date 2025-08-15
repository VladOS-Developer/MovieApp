//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by VladOS on 25.07.2025.
//

import UIKit

protocol SceneDelegateProtocol: AnyObject {
    func startMainScreen()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
//        window?.rootViewController = Builder.getPasscodeController(sceneDelegate: self) // временная заглушка
        window?.rootViewController = Builder.createTabBarController()
        window?.makeKeyAndVisible()
    }

}

extension SceneDelegate: SceneDelegateProtocol {
    
    func startMainScreen() {
        self.window?.rootViewController = Builder.createTabBarController()
    }
    
}
