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
         imageLoader: ImageLoaderProtocol,
         mode: MovieListMode)
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectItem(at index: Int)
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    private weak var view: MovieListViewProtocol?
    private let movieRepository: MovieRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let mode: MovieListMode
    private var movies: [Movie] = []
    private var movieViewModel: [MovieCellViewModel] = []
    private var allGenres: [Genres] = []
    
    private let favoritesStorage = FavoritesStorage()//
    
    required init(view: MovieListViewProtocol,
                  movieRepository: MovieRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  imageLoader: ImageLoaderProtocol,
                  mode: MovieListMode) {
        
        self.view = view
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
        self.imageLoader = imageLoader
        
        self.mode = mode
    }
    
    //MARK: - viewDidLoad
    
    func viewDidLoad() {
        view?.setTitle(mode.title)
        
        Task { [weak self] in
            guard let self else { return }
            await self.loadMovies()
        }
    }
    
    //MARK: - viewWillAppear
    
    func viewWillAppear() {
        
        Task {
            // пересобираем список с актуальными состояниями
            movieViewModel = await movies.asyncMap { movie in
                var movieVM = MovieCellViewModel(
                    movie: movie,
                    genres: allGenres,
                    isFavorite: favoritesStorage.isFavorite(id: Int32(movie.id))
                )
                // подгружаем постер, если его нет в памяти
                if movieVM.posterImage == nil {
                    movieVM.posterImage = await imageLoader.loadImage(
                        from: movieVM.posterURL,
                        localName: movie.posterPath,
                        isLocal: movie.isLocalImage
                    )
                }
                return movieVM
            }
            
            await MainActor.run {
                view?.updateMovies(movieViewModel)
            }
        }
    }
    
    //MARK: - loadMovies
    
    private func loadMovies() async {
        do {
            // Параллельный запуск загрузки жанров
            async let genresTask = genreRepository.fetchGenres()
            let moviesTask: [Movie]
            
            switch mode {
            case .top10:
                let top = try await movieRepository.fetchTopMovies()
                moviesTask = Array(top.prefix(10))
                
            case .upcoming:
                moviesTask = try await movieRepository.fetchUpcomingMovies()
                
            case .genre(let id, _):
                moviesTask = try await movieRepository.fetchMovies(byGenre: id, page: 1)
            }
            
            // Синхронизация результатов завершения обеих асинхронных задач
            let (genres, movies) = try await (genresTask, moviesTask)
            
            // Сохраняем данные в свойства презентера
            self.allGenres = genres
            self.movies = movies
            
            // Асинхронная сборка ViewModel
            let viewModels: [MovieCellViewModel] = await movies.asyncMap { movie in
                var movieVM = MovieCellViewModel(
                    movie: movie,
                    genres: genres,
                    isFavorite: favoritesStorage.isFavorite(id: Int32(movie.id))
                )
                
                movieVM.posterImage = await imageLoader.loadImage(
                    from: movieVM.posterURL,
                    localName: movie.posterPath,
                    isLocal: movie.isLocalImage
                )
                return movieVM
            }
            
            // Сохраняем готовые ViewModel
            self.movieViewModel = viewModels
            
            // Обновляем UI на главном потоке
            await MainActor.run {
                view?.updateMovies(viewModels)
            }
            
        } catch {
            print("Ошибка загрузки фильмов: \(error)")
        }
    }
    
    //MARK: - didSelectItem
    
    func didSelectItem(at index: Int) {
        let movie = movies[index]
        // проверяем id
        print("DEBUG: opening movie with id =", movie.id)
        let moviePageVC = Builder.createMoviePageController(movieId: movie.id, movieTitle: movie.title)
        (view as? UIViewController)?.navigationController?.pushViewController(moviePageVC, animated: true)
    }
    
    //MARK: - toggleFavorite
    
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

