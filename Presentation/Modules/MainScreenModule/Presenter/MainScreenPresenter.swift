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
    func didUpdateSearchQuery(_ query: String)
    func didTapSettings()
    
    init(view: MainScreenViewProtocol,
         router: MainScreenRouterProtocol,
         imageLoader: ImageLoaderProtocol,
         
         movieRepository: MovieRepositoryProtocol,
         genreRepository: GenreRepositoryProtocol,
         tvGenresRepository: TVGenresRepositoryProtocol,
         tvSeriesListsRepository: TVSeriesListsRepositoryProtocol)
}

class MainScreenPresenter {
    
    //TVSeriesListsRepositoryProtocol
    
    private weak var view: MainScreenViewProtocol?
    private let router: MainScreenRouterProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let movieRepository: MovieRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let tvGenresRepository: TVGenresRepositoryProtocol
    private let tvSeriesListsRepository: TVSeriesListsRepositoryProtocol
    
    private var sections: [MainCollectionSection] = []
    
    private var currentSearchTask: Task<(), Never>?
    private var searchDebounceWorkItem: DispatchWorkItem?
    
    required init(view: MainScreenViewProtocol,
                  router: MainScreenRouterProtocol,
                  imageLoader: ImageLoaderProtocol,
                  
                  movieRepository: MovieRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  tvGenresRepository: TVGenresRepositoryProtocol,
                  tvSeriesListsRepository: TVSeriesListsRepositoryProtocol) {
        
        self.view = view
        self.router = router
        self.imageLoader = imageLoader
        
        self.movieRepository = movieRepository
        self.genreRepository = genreRepository
        self.tvGenresRepository = tvGenresRepository
        self.tvSeriesListsRepository = tvSeriesListsRepository
        
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
                async let tvSeriesTask = tvSeriesListsRepository.fetchTVSeriesLists()
                async let tvGenresTask = tvGenresRepository.fetchTVGenres()
                
                let (genres, topMovies, upcomingMovies, tvSeries, tvGenres) = try await (genresTask, topMoviesTask, upcomingTask, tvSeriesTask, tvGenresTask)
                
                // Top rated
                let topItems: [MainCollectionItem] = await topMovies.asyncMap { movie in
                    
                    var viewModel = MovieCellViewModel(movie: movie, genres: genres)
                    viewModel.posterImage = await imageLoader.loadImage(
                        from: viewModel.posterURL,
                        localName: movie.posterPath,
                        isLocal: movie.isLocalImage
                    )
                    return .movie(viewModel)
                }
                
                // TV Series
                let seriesItems: [MainCollectionItem] = await tvSeries.asyncMap { tvSeries in
                    
                    var viewModel = TVSeriesCellViewModel(tvSeries: tvSeries, tvGenres: tvGenres)
                    viewModel.posterImage = await imageLoader.loadImage(
                        from: viewModel.posterURL,
                        localName: tvSeries.posterPath,
                        isLocal: tvSeries.isLocalImage
                    )
                    return .tvSeries(viewModel)
                }
                
                // Upcoming
                let upcomingItems: [MainCollectionItem] = await upcomingMovies.asyncMap { movie in
                    
                    var viewModel = MovieCellViewModel(movie: movie, genres: genres)
                    viewModel.posterImage = await imageLoader.loadImage(
                        from: viewModel.posterURL,
                        localName: movie.posterPath,
                        isLocal: movie.isLocalImage
                    )
                    return .movie(viewModel)
                }
                
                // Genres
                let genreItems = genres
                    .map { GenreCellViewModel(id: $0.id, name: $0.name) }
                    .map { MainCollectionItem.genre($0) }
                
                // Sections
                let sections: [MainCollectionSection] = [
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
                let genres = try await genreRepository.fetchGenres()
                let results = try await movieRepository.searchMovies(query: query, page: 1)
                
                let items: [MainCollectionItem] = await results.asyncMap { movie in
                    
                    var viewModel = MovieCellViewModel(movie: movie, genres: genres)
                    
                    viewModel.posterImage = await imageLoader.loadImage(
                        from: viewModel.posterURL,
                        localName: movie.posterPath,
                        isLocal: movie.isLocalImage
                    )
                    return .movie(viewModel)
                }
                
                await MainActor.run {
                    self.view?.reloadSearchResultsSection(with: items)
                }
            } catch {
                if !Task.isCancelled {
                    print("Search failed: \(error)")
                    
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
        default: break
        }
    }
    //MARK: - didSelectGenre
    
    func didSelectGenre(id: Int, title: String) {
        router.showMovieList(mode: .genre(id: id, title: title))
    }
    
    //MARK: - didSelectMovie
    
    func didSelectMovie(with id: Int, title: String) {
        router.showMoviePage(movieId: id, movieTitle: title )
    }
    
    //MARK: - didTapSettings
    
    func didTapSettings() {
        router.showSettingsPage()
    }
    
}


