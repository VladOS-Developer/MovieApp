//
//  MainScreenPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol MainScreenPresenterProtocol: AnyObject {
    func getMoviesData()
    
    init(view: MainScreenViewProtocol)
}

class MainScreenPresenter {
    weak var view: MainScreenViewProtocol?
    
    required init(view: MainScreenViewProtocol) {
        self.view = view
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    
    func getMoviesData() {
        let genres = Genre.mockGenres()
        let topMovies = Movie.mockTopMovies()
        let upcoming = Movie.mockUpcomingMovies()
        
        let topItems = topMovies
            .map { MovieCellViewModel(movie: $0, genres: genres) }
            .map { CollectionItem.movie($0) }

        let upcomingItems = upcoming
            .map { MovieCellViewModel(movie: $0, genres: genres) }
            .map { CollectionItem.movie($0) }

        let genreItems = genres
            .map { GenreCellViewModel(id: $0.id, name: $0.name) }
            .map { CollectionItem.genre($0) }
        
        let sections: [CollectionSection] = [
            CollectionSection(type: .genresMovie, items: genreItems),
            CollectionSection(type: .topMovie, items: topItems),
            CollectionSection(type: .upcomingMovie, items: upcomingItems)
        ]
        
        view?.showMovies(sections: sections)
    }
    
    
}
