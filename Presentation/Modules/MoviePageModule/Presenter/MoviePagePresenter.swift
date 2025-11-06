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
         imageLoader: ImageLoaderProtocol,
         
         movieDetailsRepository: MovieDetailsRepositoryProtocol,
         genreRepository: GenreRepositoryProtocol,
         movieVideoRepository: MovieVideoRepositoryProtocol,
         movieSimilarRepository: MovieSimilarRepositoryProtocol,
         movieCreditsRepository: MovieCreditsRepositoryProtocol,
         movieTitle: String,
         movieId: Int)
    
    func getMoviesData()
    func didSelectTab(index: Int)
    func toggleFavorite()
    
    func didTapPlayTrailerButton(videoVM: MovieVideoCellViewModel)
    func playPosterTrailer()
    
    func didSelectActor(castVM: CastCellViewModel)
    func didSelectSimilarMovie(_ movie: MovieSimilarCellViewModel)
}

class MoviePagePresenter: MoviePagePresenterProtocol {
    
    private weak var view: MoviePageViewProtocol?
    private let router: MoviePageRouterProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private let movieSimilarRepository: MovieSimilarRepositoryProtocol
    private let movieCreditsRepository: MovieCreditsRepositoryProtocol
    private let movieTitle: String
    private var movieId: Int
    
    private var videos: [MovieVideo] = []
    
    private var sections: [PageCollectionSection] = []
    private let favoritesStorage = FavoritesStorage()
    private var currentMovie: MovieDetails?
    
    required init(view: MoviePageViewProtocol,
                  router: MoviePageRouterProtocol,
                  imageLoader: ImageLoaderProtocol,
                  
                  movieDetailsRepository: MovieDetailsRepositoryProtocol,
                  genreRepository: GenreRepositoryProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol,
                  movieSimilarRepository: MovieSimilarRepositoryProtocol,
                  movieCreditsRepository: MovieCreditsRepositoryProtocol,
                  movieTitle: String,
                  movieId: Int) {
        
        self.view = view
        self.router = router
        self.imageLoader = imageLoader
        self.movieDetailsRepository = movieDetailsRepository
        self.genreRepository = genreRepository
        self.movieVideoRepository = movieVideoRepository
        self.movieSimilarRepository = movieSimilarRepository
        self.movieCreditsRepository = movieCreditsRepository
        self.movieId = movieId
        self.movieTitle = movieTitle
    }
    
    //MARK: - getMoviesData
    
    func getMoviesData() {
        Task {
            do {
                let genres = try await genreRepository.fetchGenres()
                let topDetails = try await movieDetailsRepository.fetchTopMovieDetails(page: 1)
                let upcomingDetails = try await movieDetailsRepository.fetchUpcomingMovieDetails(page: 1)
                let allDetails = topDetails + upcomingDetails
                
                var movieDetails: MovieDetails?
                
                if let found = allDetails.first(where: { $0.id == movieId }) {
                    movieDetails = found
                } else {
                    // Если не нашли, запрашиваем напрямую по ID
                    print("MoviePagePresenter: movie with id \(movieId) not found in top/upcoming, fetching by id...")
                    movieDetails = try await movieDetailsRepository.fetchMovieDetails(byId: movieId)
                }
                
                guard let movieDetails = movieDetails else {
                    print("MoviePagePresenter: movie with id \(movieId) not found")
                    return
                }
                
                currentMovie = movieDetails
                
                // 3) Корректно формируем viewModel — проверяем genreIDs или genres
                let genreIDs = movieDetails.genreIDs
                let movieVM = MovieDetailsCellViewModel(
                    movieDetails: movieDetails,
                    genres: genres.filter { genreIDs.contains($0.id) }
                )
                
                // 4) Загружаем постер
                var detailsVM = movieVM
                detailsVM.posterImage = await imageLoader.loadImage(
                    from: detailsVM.posterURL,
                    localName: movieDetails.posterPath,
                    isLocal: movieDetails.isLocalImage
                )
                
                // 5) Создаём секции
                let detailItem = PageCollectionItem.movieDet(detailsVM)
                self.sections = [
                    PageCollectionSection(type: .posterMovie, items: [detailItem]),
                    PageCollectionSection(type: .stackButtons, items: []),
                    PageCollectionSection(type: .specificationMovie, items: [detailItem]),
                    PageCollectionSection(type: .overviewMovie, items: [detailItem]),
                    PageCollectionSection(type: .videoMovie, items: []),
                    PageCollectionSection(type: .segmentedTabs, items: []),
                    PageCollectionSection(type: .dynamicContent, items: [])
                ]
                
                // 6) Отображаем базовую информацию
                await MainActor.run {
                    self.view?.setTitle(self.movieTitle)
                    self.view?.showMovie(sections: self.sections)
                }
                
                // 7) Подгружаем трейлеры
                let videos = try await movieVideoRepository.fetchMovieVideo(for: movieId)
                let limitedMovieVideo = Array(videos.prefix(3))
                self.videos = limitedMovieVideo
                
                // Загружаем превью через imageLoader
                let videoItems: [PageCollectionItem] = await limitedMovieVideo.asyncMap { video in
                    var videoVM = MovieVideoCellViewModel(video: video, isLocal: false)
                    
                    videoVM.thumbnailImage = await imageLoader.loadImage(
                        from: videoVM.thumbnailURL,
                        localName: nil,
                        isLocal: false
                    )
                    return .video(videoVM)
                }
                
                if let indexSection = self.sections.firstIndex(where: { $0.type == .videoMovie }) {
                    self.sections[indexSection].items = videoItems
                    
                    await MainActor.run {
                        self.view?.showMovie(sections: self.sections)
                    }
                }
                
                // 8) Проверяем избранное
                let isFavorite = favoritesStorage.isFavorite(id: Int32(movieId))
                await MainActor.run {
                    self.view?.updateFavoriteState(isFavorite: isFavorite)
                }
                
                didSelectTab(index: 0)

                
            } catch {
                print("MoviePagePresenter.getMoviesData error:", error)
            }
        }
    }
    
    //MARK: - didSelectTab
    
    func didSelectTab(index: Int) {
        Task {
            do {
                switch index {
                case 0:
                    // More like this
                    let similar = try await movieSimilarRepository.fetchSimilarMovie(for: movieId)
                    
                    let similarItems: [PageCollectionItem] = await similar.asyncMap { movieSimilar in
                        
                        var movieSimilarVM = MovieSimilarCellViewModel(movieSimilar: movieSimilar)
                        
                        // Загружаем изображение через imageLoader (учитываем локальную картинку)
                        movieSimilarVM.posterImage = await imageLoader.loadImage(
                            from: movieSimilarVM.posterURL,
                            localName: movieSimilar.posterPath,
                            isLocal: movieSimilar.isLocalImage
                        )
                        return .similarMovie(movieSimilarVM)
                    }
                    
                    if let dynamicSectionIndex = self.sections.firstIndex(where: { $0.type == .dynamicContent }) {
                        self.sections[dynamicSectionIndex].items = similarItems
                        
                        await MainActor.run {
                            self.view?.showMovie(sections: self.sections)
                        }
                    }
                    
                case 1:
                    // Cast and Crew
                    let credits = try await movieCreditsRepository.fetchCredits(for: movieId)
                    
                    let castItems: [PageCollectionItem] = await credits.cast.asyncMap { castMember in
                        
                        var castVM = CastCellViewModel(cast: castMember)
                        
                        castVM.profileImage = await imageLoader.loadImage(
                            from: castVM.profileURL,
                            localName: castMember.profilePath,
                            isLocal: castMember.isLocalImage
                        )
                        return .cast(castVM)
                    }
                                                            
                    if let dynamicSectionIndex = self.sections.firstIndex(where: { $0.type == .dynamicContent }) {
                        self.sections[dynamicSectionIndex].items = castItems
                        
                        await MainActor.run {
                            self.view?.showMovie(sections: self.sections)
                        }
                    }
                    
                default:
                    break
                }
            } catch {
                print("MoviePagePresenter.didSelectTab error:", error)
            }
        }
    }
    
    //MARK: - toggleFavorite
    
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
    
    //MARK: - didTapPlayTrailerButton
    
    func didTapPlayTrailerButton(videoVM: MovieVideoCellViewModel) {
        guard let video = videos.first(where: { $0.id == videoVM.id }) else { return }
        let movieTitle = "\(video.name)"
        
        router.showTrailerPlayer(video: video, title: movieTitle)
        
        print("videoVM.id =", videoVM.id)
        print("videos =", videos.map { $0.id })
    }
    
    //MARK: - playPosterTrailer
    
    func playPosterTrailer() {
        guard let firstVideo = videos.first else { return }
        let movieTitle = "\(firstVideo.name)"
        
        router.showTrailerPlayer(video: firstVideo, title: movieTitle)
    }
    
    //MARK: - didSelectActor
    
    func didSelectActor(castVM: CastCellViewModel) {
        router.showActorPage(actorName: castVM.name, actorId: castVM.id )
    }
    
    //MARK: - didSelectSimilarMovie
    
    func didSelectSimilarMovie(_ movie: MovieSimilarCellViewModel) {
        router.showMoviePage(movieId: movie.id, movieTitle: movie.title)
    }
    
}


