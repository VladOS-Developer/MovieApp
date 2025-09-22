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
    
    func didSelectMovie(with id: Int, title: String) {
        router.showMoviePage(movieId: id, movieTitle: title )
    }
    
}

