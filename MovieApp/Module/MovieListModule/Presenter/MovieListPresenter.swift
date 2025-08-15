//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    init(view: MovieListViewProtocol)
}

class MovieListPresenter {
    
    weak var view: MovieListViewProtocol?
    
    required init(view: MovieListViewProtocol?) {
        self.view = view
    }
}
