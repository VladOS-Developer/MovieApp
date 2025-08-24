//
//  MoviePagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import Foundation

protocol MoviePagePresenterProtocol: AnyObject {
    
    init(view: MoviePageViewProtocol, service: MovieServiceProtocol, movieId: Int)
    func getMoviesData()
    func didTapPlayTrailerButton()
}

class MoviePagePresenter: MoviePagePresenterProtocol {
    
    private weak var view: MoviePageViewProtocol?
    private let service: MovieServiceProtocol
    private let movieId: Int
    
    private var sections: [PageCollectionSection] = []
    
    required init(view: MoviePageViewProtocol, service: MovieServiceProtocol, movieId: Int) {
        self.view = view
        self.service = service
        self.movieId = movieId
    }
    
    func getMoviesData() {
        let genres = service.fetchGenres()
        
        let allMovies = service.fetchTopMovies() + service.fetchUpcomingMovies()
        guard let movie = allMovies.first(where: { $0.id == movieId }) else { return }
        
        let movieVM = MovieCellViewModel(movie: movie, genres: genres)
        let item = CollectionItem.movie(movieVM)
        
        let sections: [PageCollectionSection] = [
            PageCollectionSection(type: .posterMovie, items: [item]),
            PageCollectionSection(type: .stackButtons, items: [])
        ]
        
        self.sections = sections
        view?.showMovie(sections: sections)
        
    }
    
    func didTapPlayTrailerButton() {
        view?.navigateToTrailerPalyer()
    }

}
