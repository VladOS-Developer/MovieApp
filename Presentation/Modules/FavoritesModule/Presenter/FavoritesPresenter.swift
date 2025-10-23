//
//  FavoritesPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    init(view: FavoritesViewProtocol,
         router: FavoritesRouterProtocol,
         imageLoader: ImageLoaderProtocol)
    
    func loadFavorites()
    func numberOfItems() -> Int
    func favorite(at index: Int) -> FavoriteMovie
    func removeFavorite(id: Int32)
    func didSelectFavorite(_ movie: FavoriteMovie)
    
    func image(for favorite: FavoriteMovie) async -> UIImage?
}

final class FavoritesPresenter {
    
    private weak var view: FavoritesViewProtocol?
    private let router: FavoritesRouterProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let storage = FavoritesStorage()
    private var favorites: [FavoriteMovie] = []
        
    required init(view: FavoritesViewProtocol,
                  router: FavoritesRouterProtocol,
                  imageLoader: ImageLoaderProtocol) {
        
        self.view = view
        self.router = router
        self.imageLoader = imageLoader
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
    
    func image(for favorite: FavoriteMovie) async -> UIImage? {
        guard let posterPath = favorite.posterPath else { return nil }
        
        // сначала пробуем локальный ассет
        if let image = UIImage(named: posterPath) {
            return image
        }
        
        // иначе грузим как URL
        if let url = URL(string: posterPath) {
            return await imageLoader.loadImage(from: url, localName: nil, isLocal: false)
        }
        
        return nil
    }
}
