//
//  MoviePagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import Foundation

protocol MoviePagePresenterProtocol: AnyObject {
    
    init(view: MoviePageViewProtocol,
         movieDetailsRepository: MovieDetailsRepositoryProtocol,
         genreRepository: GenreRepositoryProtocol,
         movieVideoRepository: MovieVideoRepositoryProtocol,
         movieId: Int)
    
    func getMoviesData()
    func didTapPlayTrailerButton()
}

class MoviePagePresenter: MoviePagePresenterProtocol {
    
    private weak var view: MoviePageViewProtocol?
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private let movieId: Int
    
    private var sections: [PageCollectionSection] = []
    
    required init(view: MoviePageViewProtocol,
                  movieDetailsRepository: MovieDetailsRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol,
                  movieId: Int) {
        
        self.view = view
        self.movieDetailsRepository = movieDetailsRepository
        self.genreRepository = genreRepository
        self.movieVideoRepository = movieVideoRepository
        self.movieId = movieId
    }
    
    func getMoviesData() {
        let genres = genreRepository.fetchGenres()
        
        let allMovieDetails = movieDetailsRepository.fetchTopMovieDetails() + movieDetailsRepository.fetchUpcomingMovieDetails()
        guard let movie = allMovieDetails.first(where: { $0.id == movieId }) else { return }
        
        let movieVM = PageDetailsCellViewModel(movie: movie, genres: genres)
        let item = PageCollectionItem.movie(movieVM)
        
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
