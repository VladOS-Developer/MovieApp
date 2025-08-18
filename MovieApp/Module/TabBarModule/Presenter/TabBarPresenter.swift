//
//  TabBarViewPresenter.swift
//  MovieApp
//
//  Created by VladOS on 06.08.2025.
//

import Foundation

protocol TabBarPresenterProtocol: AnyObject {
    func buildTabBar()
    
    init(view: TabBarViewProtocol)
}

class TabBarPresenter {
    
    private weak var view: TabBarViewProtocol?
    
    required init(view: TabBarViewProtocol) {
        self.view = view
        buildTabBar()
    }
}

extension TabBarPresenter: TabBarPresenterProtocol {
    
    func buildTabBar() {
        let mainScreen = Builder.createMainScreenController()
        let playerScreen = Builder.createTrailerPlayerController()
        let favoritesScreen = Builder.createFavoritesController()
        
        self.view?.setControllers(controllers: [mainScreen, playerScreen, favoritesScreen])
    }
    
}
