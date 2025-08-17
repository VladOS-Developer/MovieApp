//
//  MainScreenPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol MainScreenPresenterProtocol: AnyObject {
    func getMoviesData()
    func didTapSeeAll(in section: Int)
    func didSelectGenre(id: Int, title: String)
    
    init(view: MainScreenViewProtocol)
}

class MainScreenPresenter {
    
    weak var view: MainScreenViewProtocol?
    private var sections: [CollectionSection] = []
    
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
        
        self.sections = sections
        view?.showMovies(sections: sections)
    }
    
    func didTapSeeAll(in section: Int) {
        guard section < sections.count else { return }
        let type = sections[section].type
        switch type {
        case .topMovie:
            view?.navigateToMovieList(mode: .top10)
        case .upcomingMovie:
            view?.navigateToMovieList(mode: .upcoming)
        default:
            break
        }
    }
    
    func didSelectGenre(id: Int, title: String) {
            view?.navigateToMovieList(mode: .genre(id: id, title: title))
        }
    
}

