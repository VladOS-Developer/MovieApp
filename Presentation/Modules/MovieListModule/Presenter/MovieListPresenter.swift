//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    init(view: MovieListViewProtocol,
         movieRepository: MovieRepositoryProtocol,
         genreRepository: GenreRepositoryProtocol,
         mode: MovieListMode)
    
    func viewDidLoad()
    func didSelectItem(at index: Int)
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    private weak var view: MovieListViewProtocol?
    private let movieRepository: MovieRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    
    private let mode: MovieListMode
    private var movies: [Movie] = []
    private var movieViewModel: [MovieCellViewModel] = []
    private var allGenres: [Genres]
    
    private let favoritesStorage = FavoritesStorage()//
    
    required init(view: MovieListViewProtocol,
                  movieRepository: MovieRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  mode: MovieListMode) {
        
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
            movies = Array(movieRepository.fetchTopMovies().prefix(10))
        case .upcoming:
            movies = movieRepository.fetchUpcomingMovies()
        case .genre(let id, _):
            movies = movieRepository.fetchMovies(byGenre: id)
        }
        
        movieViewModel = movies.map { MovieCellViewModel(movie: $0, genres: allGenres) }
        view?.updateMovies(movieViewModel)
    }
    
    func viewWillAppear() {
        // пересобираем список с актуальными состояниями
        movieViewModel = movies.map {
            MovieCellViewModel(
                movie: $0,
                genres: allGenres,
                isFavorite: favoritesStorage.isFavorite(id: Int32($0.id))
            )
        }
        view?.updateMovies(movieViewModel)
    }
    
    func didSelectItem(at index: Int) {
        let movie = movies[index]
        let moviePageVC = Builder.createMoviePageController(movieId: movie.id)
        (view as? UIViewController)?.navigationController?.pushViewController(moviePageVC, animated: true)
    }
    
    func toggleFavorite(for movieId: Int) {
        guard let movie = movies.first(where: { $0.id == movieId }) else { return }
        
        if favoritesStorage.isFavorite(id: Int32(movieId)) {
            favoritesStorage.removeFavorite(id: Int32(movieId))
        } else {
            favoritesStorage.addFavorite(
                id: Int32(movie.id),
                title: movie.title,
                posterPath: movie.posterPath ?? "",
                rating: movie.voteAverage ?? 0
            )
        }
        
        // пересобираем вьюмодели и обновляем экран
        movieViewModel = movies.map {
            MovieCellViewModel(
                movie: $0,
                genres: allGenres,
                isFavorite: favoritesStorage.isFavorite(id: Int32($0.id))
            )
        }
        view?.updateMovies(movieViewModel)
    }
    
}

