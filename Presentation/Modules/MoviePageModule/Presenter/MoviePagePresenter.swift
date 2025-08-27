//
//  MoviePagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import Foundation

protocol MoviePagePresenterProtocol: AnyObject {
    
    init(view: MoviePageViewProtocol, repository: MovieRepositoryProtocol, movieId: Int)
    func getMoviesData()
    func didTapPlayTrailerButton()
}

class MoviePagePresenter: MoviePagePresenterProtocol {
    
    private weak var view: MoviePageViewProtocol?
    private let repository: MovieRepositoryProtocol
    private let movieId: Int
    
    private var sections: [PageCollectionSection] = []
    
    required init(view: MoviePageViewProtocol, repository: MovieRepositoryProtocol, movieId: Int) {
        self.view = view
        self.repository = repository
        self.movieId = movieId
    }
    
    func getMoviesData() {
        let genres = repository.fetchGenres()
        
        let allMovies = repository.fetchTopMovies() + repository.fetchUpcomingMovies()
        guard let movie = allMovies.first(where: { $0.id == movieId }) else { return }
        
        let movieVM = MovieCellViewModel(movie: movie, genres: genres)
        let item = CollectionItem.movie(movieVM)
        
        let sections: [PageCollectionSection] = [
            PageCollectionSection(type: .posterMovie, items: [item]),
            PageCollectionSection(type: .stackButtons, items: []),
            PageCollectionSection(type: .specificationMovie, items: [item])
        ]
        
        self.sections = sections
        view?.showMovie(sections: sections)
        
    }
    
    func didTapPlayTrailerButton() {
        view?.navigateToTrailerPalyer()
    }

}
