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
    func didSelectTab(index: Int)
    func toggleFavorite()
    func didTapPlayTrailerButton(videoVM: VideoCellViewModel)
    func playMainTrailer()
}

class MoviePagePresenter: MoviePagePresenterProtocol {

    private weak var view: MoviePageViewProtocol?
    private let router: MoviePageRouterProtocol
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private let movieSimilarRepository: MovieSimilarRepositoryProtocol
    private var movieId: Int
    
    private var videos: [MovieVideo] = []
    private var sections: [PageCollectionSection] = []
    private let favoritesStorage = FavoritesStorage()
    private var currentMovie: MovieDetails?
    
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
        // 1. Жанры + все фильмы
        let genres = genreRepository.fetchGenres()
        let allMovieDetails = movieDetailsRepository.fetchTopMovieDetails() + movieDetailsRepository.fetchUpcomingMovieDetails()
        
        // 2. Текущий фильм
        guard let movieDetails = allMovieDetails.first(where: { $0.id == movieId }) else { return }
        currentMovie = movieDetails
        
        // 3. Основные секции
        let detailsVM = DetailsCellViewModel(movieDetails: movieDetails, genres: genres)
        let detailItems = PageCollectionItem.movieDet(detailsVM)
        
        self.sections = [
            PageCollectionSection(type: .posterMovie, items: [detailItems]),
            PageCollectionSection(type: .stackButtons, items: []),
            PageCollectionSection(type: .specificationMovie, items: [detailItems]),
            PageCollectionSection(type: .overviewMovie, items: [detailItems]),
            PageCollectionSection(type: .videoMovie, items: []), // пока пустая, видео загрузятся позже
            PageCollectionSection(type: .segmentedTabs, items: []),
            PageCollectionSection(type: .dynamicContent, items: []) // переключаемый контент
        ]
        
        // 4. Показываем базовую информацию сразу
        view?.showMovie(sections: sections)
        
        // 5. Подгружаем трейлеры асинхронно
        movieVideoRepository.fetchMovieVideo(for: movieId) { [weak self] videos in
            guard let self = self else { return }
            
            self.videos = videos // ✅ сохраняем
            
            let videoItems = videos
                .map { VideoCellViewModel(video: $0) }
                .map { PageCollectionItem.video($0) }
            
            if let index = self.sections.firstIndex(where: { $0.type == .videoMovie }) {
                self.sections[index].items = videoItems
                self.view?.showMovie(sections: self.sections) // обновляем только после загрузки видео
            }
        }
        
        // 6. Проверяем избранное
        let isFavorite = favoritesStorage.isFavorite(id: Int32(movieId))
        view?.updateFavoriteState(isFavorite: isFavorite)
    }
    
    func toggleFavorite() {
        guard let movie = currentMovie else { return }
        let id = Int32(movie.id)
        
        if favoritesStorage.isFavorite(id: id) {
            favoritesStorage.removeFavorite(id: id)
            view?.updateFavoriteState(isFavorite: false)
        } else {
            favoritesStorage.addFavorite(
                id: id,
                title: movie.title,
                posterPath: movie.posterPath ?? "",
                voteAverage: movie.voteAverage ?? 0
            )
            view?.updateFavoriteState(isFavorite: true)
        }
    }
    
    func playMainTrailer() {
        // Ищем главный трейлер (обычно type == "Trailer")
        guard let mainTrailer = videos.first(where: { $0.type == "Trailer" }) ?? videos.first else { return }
        router.showTrailerPlayer(video: mainTrailer)
    }
    
    func didTapPlayTrailerButton(videoVM: VideoCellViewModel) {
//        router.showTrailerPlayer(video: video)
        guard let video = videos.first(where: { $0.id == videoVM.id }) else { return }
            router.showTrailerPlayer(video: video)
    }
   
    func didSelectTab(index: Int) {
        var newItems: [PageCollectionItem] = []
        
        switch index {
        case 0: // More Like This
            let similar = movieSimilarRepository.fetchSimilarMovie(for: movieId)
            newItems = similar
                .map { SimilarMovieCellViewModel(movieSimilar: $0) }
                .map { PageCollectionItem.similarMovie($0) }
            
        case 1: // About
            newItems = []
            
        case 2: // Comments
            newItems = []
            
        default: break
        }
        
        if let dynamicSectionIndex = sections.firstIndex(where: { $0.type == .dynamicContent }) {
            sections[dynamicSectionIndex].items = newItems
            view?.showMovie(sections: sections)
        }
    }
    
}
