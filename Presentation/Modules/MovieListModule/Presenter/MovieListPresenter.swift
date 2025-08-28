//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    init(view: MovieListViewProtocol, movieRepository: MovieDetailsRepositoryProtocol, genreRepository: GenreRepositoryProtocol, mode: MovieListMode)
    func viewDidLoad()
    func didSelectItem(at index: Int)
}
// optional helpers (необязательно для текущей реализации)
//        func numberOfItems() -> Int
//        func item(at index: Int) -> MovieCellViewModel
//        func didSelectItem(at index: Int)

class MovieListPresenter: MovieListPresenterProtocol {
    
    private weak var view: MovieListViewProtocol?
    private let movieRepository: MovieDetailsRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    
    private let mode: MovieListMode
    
    private var movies: [MovieDetails] = []
    private var movieViewModel: [MainDetailsCellViewModel] = []
    private var allGenres: [Genres]
    
    required init(view: MovieListViewProtocol, movieRepository: MovieDetailsRepositoryProtocol, genreRepository: GenreRepositoryProtocol, mode: MovieListMode) {
        self.view = view
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
        
        self.mode = mode
        self.allGenres = genreRepository.fetchGenres()
    }
    
    func viewDidLoad() {
        view?.setTitle(mode.title)
        
        switch mode {
        case .top10:
            movies = Array(movieRepository.fetchTopMovieDetails().prefix(10))
        case .upcoming:
            movies = movieRepository.fetchUpcomingMovieDetails()
        case .genre(let id, _):
            movies = movieRepository.fetchMovieDetails(byGenre: id)
        }
        
        movieViewModel = movies.map { MainDetailsCellViewModel(movie: $0, genres: allGenres) }
        view?.updateMovies(movieViewModel)
    }
    
    func didSelectItem(at index: Int) {
        let movie = movies[index]
        let moviePageVC = Builder.createMoviePageController(movieId: movie.id)
        (view as? UIViewController)?.navigationController?.pushViewController(moviePageVC, animated: true)
    }
    
}
// helpers (на будущее)
//        func numberOfItems() -> Int { vms.count }
//        func item(at index: Int) -> MovieCellViewModel { vms[index] }
//        func didSelectItem(at index: Int) {
//            // тут позже будет переход на детали
//        }
