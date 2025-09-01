//
//  MoviePagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import Foundation

protocol MoviePagePresenterProtocol: AnyObject {
    
    init(view: MoviePageViewProtocol,
         router: MoviePageRouterProtocol,
         movieDetailsRepository: MovieDetailsRepositoryProtocol,
         genreRepository: GenreRepositoryProtocol,
         movieVideoRepository: MovieVideoRepositoryProtocol,
         movieId: Int)
    
    func getMoviesData()
    func didTapPlayTrailerButton()
}

class MoviePagePresenter: MoviePagePresenterProtocol {
    
    private weak var view: MoviePageViewProtocol?
    private let router: MoviePageRouterProtocol
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private let movieId: Int
    
    private var sections: [PageCollectionSection] = []
    
    required init(view: MoviePageViewProtocol,
                  router: MoviePageRouterProtocol,
                  movieDetailsRepository: MovieDetailsRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol,
                  movieId: Int) {
        
        self.view = view
        self.router = router
        self.movieDetailsRepository = movieDetailsRepository
        self.genreRepository = genreRepository
        self.movieVideoRepository = movieVideoRepository
        self.movieId = movieId
    }
    
    func getMoviesData() {
        let genres = genreRepository.fetchGenres()
        
        let allMovieDetails = movieDetailsRepository.fetchTopMovieDetails() + movieDetailsRepository.fetchUpcomingMovieDetails()
        guard let movieDetails = allMovieDetails.first(where: { $0.id == movieId }) else { return }
        
        let detailsVM = PageDetailsCellViewModel(movieDetails: movieDetails, genres: genres)
        let detailItems = PageCollectionItem.movieDet(detailsVM)
        
        let videos = movieVideoRepository.fetchMovieVideo(for: movieId)
        let videoItems = videos
            .map { PageVideoCellViewModel(video: $0) }
            .map { PageCollectionItem.video($0) }
        
        let sections: [PageCollectionSection] = [
            PageCollectionSection(type: .posterMovie, items: [detailItems]),
            PageCollectionSection(type: .stackButtons, items: []),
            PageCollectionSection(type: .specificationMovie, items: [detailItems]),
            PageCollectionSection(type: .overviewMovie, items: [detailItems]),
            PageCollectionSection(type: .videoMovie, items: videoItems),
            PageCollectionSection(type: .segmentedTabs, items: []), // вкладки
//            PageCollectionSection(type: .dynamicContent, items: []) // контент меняется при переключении
        ]
        
        self.sections = sections
        view?.showMovie(sections: sections)
        
    }
    
    func didTapPlayTrailerButton() {
        router.showTrailerPlayer()
    }

}
