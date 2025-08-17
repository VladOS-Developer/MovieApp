//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    init(view: MovieListViewProtocol, service: MovieServiceProtocol, mode: MovieListMode)
    func viewDidLoad()
}
// optional helpers (необязательно для текущей реализации)
//        func numberOfItems() -> Int
//        func item(at index: Int) -> MovieCellViewModel
//        func didSelectItem(at index: Int)

class MovieListPresenter: MovieListPresenterProtocol {
    
    private weak var view: MovieListViewProtocol?
    private let service: MovieServiceProtocol
    private let mode: MovieListMode
    
    private var movies: [Movie] = []
    private var vms: [MovieCellViewModel] = []
    private var allGenres: [Genre]
    
    required init(view: MovieListViewProtocol, service: MovieServiceProtocol, mode: MovieListMode) {
        self.view = view
        self.service = service
        self.mode = mode
        self.allGenres = service.fetchGenres()
    }
    
    func viewDidLoad() {
        view?.setTitle(mode.title)
        
        switch mode {
        case .top10:
            movies = Array(service.fetchTopMovies().prefix(10))
        case .upcoming:
            movies = service.fetchUpcomingMovies()
        case .genre(let id, _):
            movies = service.fetchMovies(byGenre: id)
        }
        
        vms = movies.map { MovieCellViewModel(movie: $0, genres: allGenres) }
        view?.updateMovies(vms)
    }
    
}
// helpers (на будущее)
//        func numberOfItems() -> Int { vms.count }
//        func item(at index: Int) -> MovieCellViewModel { vms[index] }
//        func didSelectItem(at index: Int) {
//            // тут позже будет переход на детали
//        }
