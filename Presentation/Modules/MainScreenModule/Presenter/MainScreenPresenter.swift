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
    
    private var currentSearchTask: Task<(), Never>?
    private var searchDebounceWorkItem: DispatchWorkItem?
    
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
        
        Task {
            do {
                async let genresTask = genreRepository.fetchGenres()
                async let topMoviesTask = movieRepository.fetchTopMovies()
                async let upcomingTask = movieRepository.fetchUpcomingMovies()
                
                let (genres, topMovies, upcomingMovies) = try await (genresTask, topMoviesTask, upcomingTask)
                
                let genreItems = genres.map { GenreCellViewModel(id: $0.id, name: $0.name) }
                    .map { MainCollectionItem.genre($0) }
                
                let topItems = topMovies.map { MovieCellViewModel(movie: $0, genres: genres) }
                    .map { MainCollectionItem.movie($0) }
                
                let upcomingItems = upcomingMovies.map { MovieCellViewModel(movie: $0, genres: genres) }
                    .map { MainCollectionItem.movie($0) }
                
                let sections: [MainCollectionSection] = [
                    MainCollectionSection(type: .searchHeader, items: [.searchHeaderItem]),
                    MainCollectionSection(type: .searchResults, items: []),
                    MainCollectionSection(type: .genresMovie, items: genreItems),
                    MainCollectionSection(type: .topMovie, items: topItems),
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
    
    private func performSearch(_ query: String) {
        currentSearchTask?.cancel()
        
        currentSearchTask = Task {
            do {
                let genres = try await genreRepository.fetchGenres()
                let results = try await movieRepository.searchMovies(query: query, page: 1)
                let items = results.map { MainCollectionItem.movie(MovieCellViewModel(movie: $0, genres: genres)) }

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
    
    func didSelectGenre(id: Int, title: String) {
        router.showMovieList(mode: .genre(id: id, title: title))
    }
    
    func didSelectMovie(with id: Int, title: String) {
        router.showMoviePage(movieId: id, movieTitle: title )
    }
    
}

