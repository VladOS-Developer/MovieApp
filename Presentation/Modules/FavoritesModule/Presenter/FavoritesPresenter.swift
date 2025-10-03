//
//  FavoritesPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesViewProtocol,
         router: FavoritesRouterProtocol)
    
    func loadFavorites()
    func numberOfItems() -> Int
    func favorite(at index: Int) -> FavoriteMovie
    func removeFavorite(id: Int32)
    func didSelectFavorite(_ movie: FavoriteMovie)
}

final class FavoritesPresenter {
    
    private weak var view: FavoritesViewProtocol?
    private let router: FavoritesRouterProtocol
    
    private let storage = FavoritesStorage()
    private var favorites: [FavoriteMovie] = []
    
    required init(view: FavoritesViewProtocol,
                  router: FavoritesRouterProtocol) {
        
        self.view = view
        self.router = router
    }
    
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    
    func didSelectFavorite(_ movie: FavoriteMovie) {
        router.openMoviePage(movieId: Int(movie.id), movieTitle: movie.title ?? "")
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
    
    func removeFavorite(id: Int32) {
        storage.removeFavorite(id: id)
        loadFavorites()
    }
}
