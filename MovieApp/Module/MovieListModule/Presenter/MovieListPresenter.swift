//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    init(view: MovieListViewProtocol, mode: MovieListMode)
    func setTitleMode()
}

class MovieListPresenter: MovieListPresenterProtocol {
    
  
    weak var view: MovieListViewProtocol?
    private let mode: MovieListMode
    
    required init(view: MovieListViewProtocol, mode: MovieListMode) {
        self.view = view
        self.mode = mode
    }
    
    func setTitleMode() {
        view?.setTitle(mode.title)
        // Здесь в будущем запрашиваем данные из репозитория в зависимости от mode
    }
}
