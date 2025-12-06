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
    func didSelectMovie(with id: Int, title: String)
    func didSelectTVSeries(with id: Int, title: String)
    func didUpdateSearchQuery(_ query: String)
    func didTapSettings()
    
    init(view: MainScreenViewProtocol,
         router: MainScreenRouterProtocol,
         imageLoader: ImageLoaderProtocol,
         movieRepository: MovieRepositoryProtocol,
         genreRepository: GenreRepositoryProtocol,
         tvGenresRepository: TVGenresRepositoryProtocol,
         tvSeriesRepository: TVSeriesRepositoryProtocol)
}

class MainScreenPresenter {
        
    private weak var view: MainScreenViewProtocol?
    private let router: MainScreenRouterProtocol
    private let imageLoader: ImageLoaderProtocol
    private let movieRepository: MovieRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let tvGenresRepository: TVGenresRepositoryProtocol
    private let tvSeriesRepository: TVSeriesRepositoryProtocol
    
    private var sections: [MainCollectionSection] = []
    
    private var currentSearchTask: Task<(), Never>?
    private var searchDebounceWorkItem: DispatchWorkItem?
    
    required init(view: MainScreenViewProtocol,
                  router: MainScreenRouterProtocol,
                  imageLoader: ImageLoaderProtocol,
                  movieRepository: MovieRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  tvGenresRepository: TVGenresRepositoryProtocol,
                  tvSeriesRepository: TVSeriesRepositoryProtocol) {
        
        self.view = view
        self.router = router
        self.imageLoader = imageLoader
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
        self.tvGenresRepository = tvGenresRepository
        self.tvSeriesRepository = tvSeriesRepository
        
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    
    //MARK: - getMoviesData
    
    func getMoviesData() {
        Task {
            do {
                async let genresTask = genreRepository.fetchGenres()
                async let topMoviesTask = movieRepository.fetchTopMovies()
                async let upcomingTask = movieRepository.fetchUpcomingMovies()
                async let tvSeriesTask = tvSeriesRepository.fetchTVSeries()
                async let tvGenresTask = tvGenresRepository.fetchTVGenres()
                
                let (genres, topMovies, upcomingMovies, tvSeriesCombo, tvGenres) = try await (genresTask, topMoviesTask, upcomingTask, tvSeriesTask, tvGenresTask)
                
                // Top Movies
                let topItems: [MainCollectionItem] = await topMovies.asyncMap { movie in
                    var viewModel = MovieCellViewModel(movie: movie, genres: genres)
                    viewModel.posterImage = await imageLoader.loadImage(from: viewModel.posterURL,
                                                                        localName: movie.posterPath,
                                                                        isLocal: movie.isLocalImage)
                    return .movie(viewModel)
                }
                
                // TV Series
                let seriesItems: [MainCollectionItem] = await tvSeriesCombo.asyncMap { tvSeries in
                    var viewModel = TVSeriesCellViewModel(tvSeries: tvSeries, tvGenres: tvGenres)
                    viewModel.posterImage = await imageLoader.loadImage(from: viewModel.posterURL,
                                                                        localName: tvSeries.posterPath,
                                                                        isLocal: tvSeries.isLocalImage)
                    return .tvSeries(viewModel)
                }
                
                // Upcoming
                let upcomingItems: [MainCollectionItem] = await upcomingMovies.asyncMap { movie in
                    var viewModel = MovieCellViewModel(movie: movie, genres: genres)
                    viewModel.posterImage = await imageLoader.loadImage(from: viewModel.posterURL,
                                                                        localName: movie.posterPath,
                                                                        isLocal: movie.isLocalImage)
                    return .movie(viewModel)
                }
                
                // Genres
                let genreItems = genres
                    .map { GenreCellViewModel(id: $0.id, name: $0.name) }
                    .map { MainCollectionItem.genre($0) }
                
                // Sections
                let sections: [MainCollectionSection] = [
                    MainCollectionSection(type: .tmdbAttribution, items: [.TMDBHeaderItem]),
                    MainCollectionSection(type: .searchHeader, items: [.searchHeaderItem]),
                    MainCollectionSection(type: .searchResults, items: []),
                    MainCollectionSection(type: .genresMovie, items: genreItems),
                    MainCollectionSection(type: .topMovie, items: topItems),
                    MainCollectionSection(type: .tvSeries, items: seriesItems),
                    MainCollectionSection(type: .upcomingMovie, items: upcomingItems)
                ]
                
                self.sections = sections
                
                await MainActor.run {
                    self.view?.showMovies(sections: sections)
                }
            } catch {
                print("Failed to fetch movies: \(error)")
            }
        }
    }
    
    //MARK: - didUpdateSearchQuery
    
    func didUpdateSearchQuery(_ query: String) {
        // Отменяем предыдущий debounce
        searchDebounceWorkItem?.cancel()
        
        let trimmed = query.trimmingCharacters(in: .whitespaces)
        
        // Если запрос короткий (<3), сразу очищаем результаты
        if trimmed.count < 3 {
            currentSearchTask?.cancel()
            
            Task { @MainActor in
                self.view?.reloadSearchResultsSection(with: [])
            }
            return
        }
        
        // Делаем debounce на 0.5 сек
        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.performSearch(trimmed)
        }
        searchDebounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
    
    //MARK: - performSearch

    private func performSearch(_ query: String) {
        currentSearchTask?.cancel()
        
        currentSearchTask = Task {
            do {
                async let genresResult = genreRepository.fetchGenres()
                async let tvGenresResult = tvGenresRepository.fetchTVGenres()
                async let movieResults = movieRepository.searchMovies(query: query, page: 1)
                async let tvSeriesResults = tvSeriesRepository.searchTVSeries(query: query, page: 1)
                
                let (genres, tvGenres, movies, series) = try await (genresResult, tvGenresResult, movieResults, tvSeriesResults)
                
                print("DEBUG: presenter got \(series.count) series for query '\(query)'")
                
                let movieItems: [MainCollectionItem] = await movies.asyncMap { movie in
                    var movieVM = MovieCellViewModel(movie: movie, genres: genres)
                    movieVM.posterImage = await imageLoader.loadImage(from: movieVM.posterURL,
                                                                      localName: movie.posterPath,
                                                                      isLocal: movie.isLocalImage)
                    return .movie(movieVM)
                }
                
                let seriesItems: [MainCollectionItem] = await series.asyncMap { series in
                    var seriesVM = TVSeriesCellViewModel(tvSeries: series, tvGenres: tvGenres)
                    seriesVM.posterImage = await imageLoader.loadImage(from: seriesVM.posterURL,
                                                                       localName: series.posterPath,
                                                                       isLocal: series.isLocalImage)
                    return .tvSeries(seriesVM)
                }
                
                let allResultItems = movieItems + seriesItems
                
                await MainActor.run {
                    self.view?.reloadSearchResultsSection(with: allResultItems)
                }
                
            } catch {
                if !Task.isCancelled {
                    await MainActor.run {
                        self.view?.reloadSearchResultsSection(with: [])
                    }
                }
            }
        }
    }
    
    //MARK: - didTapSeeAll
    
    func didTapSeeAll(in section: Int) {
        guard section < sections.count else { return }
        
        switch sections[section].type {
        case .topMovie:
            router.showMovieList(mode: .top10)
        case .upcomingMovie:
            router.showMovieList(mode: .upcoming)
        case .tvSeries:
            router.showMovieList(mode: .tvSeries)
        default: break
        }
    }
    //MARK: - didSelectGenre
    
    func didSelectGenre(id: Int, title: String) {
        router.showMovieList(mode: .genre(id: id, title: title))
    }
    
    //MARK: - didSelectMovie
    
    func didSelectMovie(with id: Int, title: String) {
        router.showMoviePage(id: id, title: title)
    }
    
    //MARK: - didSelectTVSeries
    
    func didSelectTVSeries(with id: Int, title: String) {
        router.showTVSeriesPage(id: id, title: title)
    }
    
    //MARK: - didTapSettings
    
    func didTapSettings() {
        router.showSettingsPage()
    }
    
}


