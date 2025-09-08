//
//  FavoritesPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesViewProtocol)
    
    func loadFavorites()
    func numberOfItems() -> Int
    func favorite(at index: Int) -> FavoriteMovie
}

final class FavoritesPresenter {
    private weak var view: FavoritesViewProtocol?
    private let storage = FavoritesStorage()
    private var favorites: [FavoriteMovie] = []
    
    required init(view: FavoritesViewProtocol) {
        self.view = view
    }
    
    func loadFavorites() {
        favorites = storage.fetchFavorites()
        view?.reloadFavorites()
    }
    
    func numberOfItems() -> Int {
        favorites.count
    }
    
    func favorite(at index: Int) -> FavoriteMovie {
        favorites[index]
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
}
