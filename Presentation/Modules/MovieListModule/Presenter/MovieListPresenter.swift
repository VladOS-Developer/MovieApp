//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectItem(at index: Int)
    
    init(view: MovieListViewProtocol,
         mode: MovieListMode,
         imageLoader: ImageLoaderProtocol,
         
         movieRepository: MovieRepositoryProtocol,
         genreRepository: GenreRepositoryProtocol,
         tvGenresRepository: TVGenresRepositoryProtocol,
         tvSeriesRepository: TVSeriesRepositoryProtocol)
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    private weak var view: MovieListViewProtocol?
    public let mode: MovieListMode
    private let imageLoader: ImageLoaderProtocol
    
    private let movieRepository: MovieRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let tvGenresRepository: TVGenresRepositoryProtocol
    private let tvSeriesListsRepository: TVSeriesRepositoryProtocol
    
    private var movies: [Movie] = []
    private var genres: [Genres] = []
    private var movieViewModel: [MovieCellViewModel] = []
    
    private var tvSeries: [TVSeries] = []
    private var tvGenres: [TVGenres] = []
    private var seriesViewModel: [TVSeriesCellViewModel] = []
    
    private let favoritesStorage = FavoritesStorage()
    
    required init(view: MovieListViewProtocol,
                  mode: MovieListMode,
                  imageLoader: ImageLoaderProtocol,
                  
                  movieRepository: MovieRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  tvGenresRepository: TVGenresRepositoryProtocol,
                  tvSeriesRepository: TVSeriesRepositoryProtocol) {
        
        self.view = view
        self.mode = mode
        self.imageLoader = imageLoader
        
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
        self.tvGenresRepository = tvGenresRepository
        self.tvSeriesListsRepository = tvSeriesRepository
        
    }
    
    //MARK: - viewDidLoad
    
    func viewDidLoad() {
        view?.setTitle(mode.title)
        
        Task { [weak self] in
            guard let self else { return }
            await self.loadContext()
        }
    }
    
    //MARK: - viewWillAppear

    func viewWillAppear() {
        Task {
            await buildViewModels()
        }
    }

    //MARK: - buildViewModels

    private func buildViewModels() async {
        // Movies
        movieViewModel = await movies.asyncMap { movie in
            var movieVM = MovieCellViewModel(
                movie: movie,
                genres: genres,
                isFavorite: favoritesStorage.isFavorite(id: Int32(movie.id))
            )
            if movieVM.posterImage == nil {
                movieVM.posterImage = await imageLoader.loadImage(
                    from: movieVM.posterURL,
                    localName: movie.posterPath,
                    isLocal: movie.isLocalImage
                )
            }
            return movieVM
        }

        // TVSeries
        seriesViewModel = await tvSeries.asyncMap { series in
            var seriesVM = TVSeriesCellViewModel(tvSeries: series, tvGenres: [])
            if seriesVM.posterImage == nil {
                seriesVM.posterImage = await imageLoader.loadImage(
                    from: seriesVM.posterURL,
                    localName: series.posterPath,
                    isLocal: series.isLocalImage
                )
            }
            return seriesVM
        }

        await MainActor.run {
            switch mode {
            case .tvSeries:
                view?.updateSeries(seriesViewModel)
            default:
                view?.updateMovies(movieViewModel)
            }
        }
    }
    
    
    //MARK: - loadContext
    
    private func loadContext() async {
        do {
            async let genresTask = genreRepository.fetchGenres()
            async let tvGenresTask = tvGenresRepository.fetchTVGenres()
            let moviesTask: [Movie]
            let tvSeriesTask: [TVSeries]

            switch mode {
            case .top10:
                moviesTask = try await movieRepository.fetchTopMovies()
                tvSeriesTask = []
                
            case .upcoming:
                moviesTask = try await movieRepository.fetchUpcomingMovies()
                tvSeriesTask = []
                
            case .genre(let id, _):
                moviesTask = try await movieRepository.fetchMovies(byGenre: id, page: 1)
                tvSeriesTask = []
                
            case .tvSeries:
                moviesTask = []
                tvSeriesTask = try await tvSeriesListsRepository.fetchTVSeriesTopRate(page: 1)
            }

            let (genres, tvGenres, movies, tvSeries) = try await (genresTask, tvGenresTask, moviesTask, tvSeriesTask)

            self.genres = genres
            self.movies = movies
            self.tvSeries = tvSeries
            self.tvGenres = tvGenres
            
            print("Movies: \(movies.count), Series: \(tvSeries.count)")
            
            await buildViewModels()
            
        } catch {
            print("Ошибка загрузки фильмов/сериалов: \(error)")
        }
        
    }
    
    //MARK: - didSelectItem
    
//    func didSelectItem(at index: Int) {
//        let movie = movies[index]
//        // проверяем id
//        print("DEBUG: opening movie with id =", movie.id)
//        let moviePageVC = Builder.createMoviePageController(id: movie.id, title: movie.title)
//        (view as? UIViewController)?.navigationController?.pushViewController(moviePageVC, animated: true)
//    }
    func didSelectItem(at index: Int) {
        
        switch mode {
        case .tvSeries:
            let tvSeries = tvSeries[index]
            let moviePageVC = Builder.createMoviePageController(id: tvSeries.id, title: tvSeries.name)
            (view as? UIViewController)?.navigationController?.pushViewController(moviePageVC, animated: true)
        default:
            let movie = movies[index]
            // проверяем id
            print("DEBUG: opening movie with id =", movie.id)
            let moviePageVC = Builder.createMoviePageController(id: movie.id, title: movie.title)
            (view as? UIViewController)?.navigationController?.pushViewController(moviePageVC, animated: true)
        }
    }
    
    //MARK: - toggleFavorite
    
    func toggleFavorite(for id: Int) {
        
        switch mode {
        case .tvSeries:
            guard let index = tvSeries.firstIndex(where: { $0.id == id }) else { return }
            let series = tvSeries[index]
            
            if favoritesStorage.isFavorite(id: Int32(id)) {
                favoritesStorage.removeFavorite(id: Int32(id))
            } else {
                favoritesStorage.addFavorite(
                    id: Int32(series.id),
                    title: series.name,
                    posterPath: series.posterPath ?? "",
                    voteAverage: series.voteAverage ?? 0
                )
            }
            
            seriesViewModel[index].isFavorite = favoritesStorage.isFavorite(id: Int32(id))
            view?.updateFavoriteState(at: index, isFavorite: seriesViewModel[index].isFavorite)
            
        default:  // фильмы
            guard let index = movies.firstIndex(where: { $0.id == id }) else { return }
            let movie = movies[index]
            
            if favoritesStorage.isFavorite(id: Int32(id)) {
                favoritesStorage.removeFavorite(id: Int32(id))
            } else {
                favoritesStorage.addFavorite(
                    id: Int32(movie.id),
                    title: movie.title,
                    posterPath: movie.posterPath ?? "",
                    voteAverage: movie.voteAverage ?? 0
                )
            }
            
            movieViewModel[index].isFavorite = favoritesStorage.isFavorite(id: Int32(id))
            view?.updateFavoriteState(at: index, isFavorite: movieViewModel[index].isFavorite)
        }
    }
    
}
