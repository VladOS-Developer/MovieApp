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
    
    weak var view: TabBarViewProtocol?
    
    required init(view: TabBarViewProtocol) {
        self.view = view
    }
}


extension TabBarPresenter: TabBarPresenterProtocol {
    
    func buildTabBar() {
        
    }
    
}
