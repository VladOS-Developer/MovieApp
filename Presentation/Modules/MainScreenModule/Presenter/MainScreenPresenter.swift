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
    func didSelectMovie(with id: Int)
    
    init(view: MainScreenViewProtocol,
         router: MainScreenRouterProtocol,
         movieRepository: MovieRepositoryProtocol,
         genreRepository: GenreRepositoryProtocol)
}

class MainScreenPresenter {
    
    private weak var view: MainScreenViewProtocol?
    private let router: MainScreenRouterProtocol
    private let movieRepository: MovieRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    
    private var sections: [MainCollectionSection] = []
    
    required init(view: MainScreenViewProtocol,
                  router: MainScreenRouterProtocol,
                  movieRepository: MovieRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol) {
        
        self.view = view
        self.router = router
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    
    func getMoviesData() {
        let genres = genreRepository.fetchGenres()
        let topMovies = movieRepository.fetchTopMovies()
        let upcoming = movieRepository.fetchUpcomingMovies()
        
        let genreItems = genres
            .map { GenreCellViewModel(id: $0.id, name: $0.name) }
            .map { MainCollectionItem.genre($0) }
        
        let topItems = topMovies
            .map { MovieCellViewModel(movie: $0, genres: genres) }
            .map { MainCollectionItem.movie($0) }
        
        let upcomingItems = upcoming
            .map { MovieCellViewModel(movie: $0, genres: genres) }
            .map { MainCollectionItem.movie($0) }
        
        let sections: [MainCollectionSection] = [
            MainCollectionSection(type: .genresMovie, items: genreItems),
            MainCollectionSection(type: .topMovie, items: topItems),
            MainCollectionSection(type: .upcomingMovie, items: upcomingItems)
        ]
        
        self.sections = sections
        view?.showMovies(sections: sections)
    }
    
    func didTapSeeAll(in section: Int) {
        guard section < sections.count else { return }
        switch sections[section].type {
        case .topMovie:      router.showMovieList(mode: .top10)
        case .upcomingMovie: router.showMovieList(mode: .upcoming)
        default: break
        }
    }
    
    func didSelectGenre(id: Int, title: String) {
        router.showMovieList(mode: .genre(id: id, title: title))
    }
    
    func didSelectMovie(with id: Int) {
        router.showMoviePage(movieId: id)
    }
    
}

