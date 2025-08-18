//
//  MoviePagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import Foundation

protocol MoviePagePresenterProtocol: AnyObject {
    
    init(view: MoviePageViewProtocol, service: MovieServiceProtocol, movieId: Int)
    func viewDidLoad()
}

class MoviePagePresenter: MoviePagePresenterProtocol {
    
    private weak var view: MoviePageViewProtocol?
    private let service: MovieServiceProtocol
    private let movieId: Int
    
    required init(view: MoviePageViewProtocol, service: MovieServiceProtocol, movieId: Int) {
        self.view = view
        self.service = service
        self.movieId = movieId
    }
    
    func viewDidLoad() {
        guard let movie = service.fetchMovie(id: movieId) else { return }
        view?.setTitle(movie.title)
        // пока просто заглушка под постер из локальных моков
        let posterName = movie.isLocalImage ? movie.posterPath : nil
        view?.showPoster(named: posterName)
    }
    
}
