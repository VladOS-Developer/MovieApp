//
//  FavoritesPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesViewProtocol)
   
}

final class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?

    required init(view: FavoritesViewProtocol) {
        self.view = view
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {

    
}
