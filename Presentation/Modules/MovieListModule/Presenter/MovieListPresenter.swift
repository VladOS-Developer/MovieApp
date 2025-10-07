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
    func viewWillAppear()
    func didSelectItem(at index: Int)
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    private weak var view: MovieListViewProtocol?
    private let movieRepository: MovieRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    
    private let mode: MovieListMode
    private var movies: [Movie] = []
    private var movieViewModel: [MovieCellViewModel] = []
    private var allGenres: [Genres] = []
    
    private let favoritesStorage = FavoritesStorage()//
    
    required init(view: MovieListViewProtocol,
                  movieRepository: MovieRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  mode: MovieListMode) {
        
        self.view = view
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
        
        self.mode = mode
    }
    
    func viewDidLoad() {
        view?.setTitle(mode.title)
        
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.allGenres = try await self.genreRepository.fetchGenres()
                
                switch self.mode {
                case .top10:
                    let top = try await self.movieRepository.fetchTopMovies()
                    self.movies = Array(top.prefix(10))
                    
                case .upcoming:
                    self.movies = try await self.movieRepository.fetchUpcomingMovies()
                    
                case .genre(let id, _):
                    self.movies = try await self.movieRepository.fetchMovies(byGenre: id, page: 1)
                }
                
                self.movieViewModel = self.movies.map {
                    MovieCellViewModel(movie: $0, genres: self.allGenres)
                }
                self.view?.updateMovies(self.movieViewModel)
            } catch {
                print("Ошибка загрузки фильмов: \(error)")
            }
        }
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
        let moviePageVC = Builder.createMoviePageController(movieId: movie.id, movieTitle: movie.title)
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
                voteAverage: movie.voteAverage ?? 0
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

