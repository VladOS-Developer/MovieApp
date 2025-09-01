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
         movieSimilarRepository: MovieSimilarRepositoryProtocol,
         movieId: Int)
    
    func getMoviesData()
    func didTapPlayTrailerButton()
    func didSelectTab(index: Int)
}

class MoviePagePresenter: MoviePagePresenterProtocol {
        
    private weak var view: MoviePageViewProtocol?
    private let router: MoviePageRouterProtocol
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private let movieSimilarRepository: MovieSimilarRepositoryProtocol
    private let movieId: Int
    
    private var sections: [PageCollectionSection] = []
    
    required init(view: MoviePageViewProtocol,
                  router: MoviePageRouterProtocol,
                  movieDetailsRepository: MovieDetailsRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol,
                  movieSimilarRepository: MovieSimilarRepositoryProtocol,
                  movieId: Int) {
        
        self.view = view
        self.router = router
        self.movieDetailsRepository = movieDetailsRepository
        self.genreRepository = genreRepository
        self.movieVideoRepository = movieVideoRepository
        self.movieSimilarRepository = movieSimilarRepository
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
            PageCollectionSection(type: .dynamicContent, items: []) // контент меняется при переключении
        ]
        
        self.sections = sections
        view?.showMovie(sections: sections)
        
    }
    
    func didTapPlayTrailerButton() {
        router.showTrailerPlayer()
    }
    
    func didSelectTab(index: Int) {
        var newItems: [PageCollectionItem] = []
        
        switch index {
        case 0: // More Like This
            let similar = movieSimilarRepository.fetchSimilarMovie(for: movieId)
            newItems = similar
                .map { SimilarMovieCellViewModel(similar: $0, isLocal: true) }
                .map { PageCollectionItem.similarMovie($0) }
            
        case 1: // About
            newItems = []
            
        case 2: // Comments
            newItems = []
            
        default: break
        }
        
        if let dynamicSectionIndex = sections.firstIndex(where: { $0.type == .dynamicContent }) {
            sections[dynamicSectionIndex].items = newItems
            view?.showMovie(sections: sections) // ✅ обновляем вью через протокол
        }
    }

}
