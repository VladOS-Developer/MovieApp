//
//  TVPagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 03.11.2025.
//

import UIKit

protocol TVPagePresenterProtocol: AnyObject {
    
    init(view: TVPageViewProtocol,
         router: TVPageRouterProtocol,
         imageLoader: ImageLoaderProtocol,
         
         tvDetailsRepository: TVDetailsRepositoryProtocol,
         tvGenreRepository: TVGenresRepositoryProtocol,
         tvVideoRepository: TVVideoRepositoryProtocol,
         tvSimilarRepository: TVSimilarRepositoryProtocol,
         tvCreditsRepository: TVCreditsRepositoryProtocol,
         
         tvTitle: String,
         tvId: Int)
    
    func getTVData()
    func didSelectTab(index: Int)
    func toggleFavorite()
    
    func didTapPlayTrailerButton(videoVM: TVVideoCellViewModel)
    func playPosterTrailer()
    
    func didSelectActor(castVM: TVCastCellViewModel)
    func didSelectSimilarMovie(_ tv: TVSimilarCellViewModel)
}

class TVPagePresenter: TVPagePresenterProtocol {
  
    private weak var view: TVPageViewProtocol?
    private let router: TVPageRouterProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let tvDetailsRepository: TVDetailsRepositoryProtocol
    private let tvGenreRepository: TVGenresRepositoryProtocol
    private let tvVideoRepository: TVVideoRepositoryProtocol
    private let tvSimilarRepository: TVSimilarRepositoryProtocol
    private let tvCreditsRepository: TVCreditsRepositoryProtocol
    
    private let tvTitle: String
    private var tvId: Int
    
    private var videos: [TVVideo] = []
    private var sections: [TVPageCollectionSection] = []
    private let favoritesStorage = FavoritesStorage()
    private var currentTVMovie: TVDetails?
    
    required init(view: TVPageViewProtocol,
                  router: TVPageRouterProtocol,
                  imageLoader: ImageLoaderProtocol,
                  
                  tvDetailsRepository: TVDetailsRepositoryProtocol,
                  tvGenreRepository: TVGenresRepositoryProtocol,
                  tvVideoRepository: TVVideoRepositoryProtocol,
                  tvSimilarRepository: TVSimilarRepositoryProtocol,
                  tvCreditsRepository: TVCreditsRepositoryProtocol,
                  
                  tvTitle: String,
                  tvId: Int) {
        
        self.view = view
        self.router = router
        self.imageLoader = imageLoader
        self.tvDetailsRepository = tvDetailsRepository
        self.tvGenreRepository = tvGenreRepository
        self.tvVideoRepository = tvVideoRepository
        self.tvSimilarRepository = tvSimilarRepository
        self.tvCreditsRepository = tvCreditsRepository
        self.tvTitle = tvTitle
        self.tvId = tvId
    }

    //MARK: - getTVData
    
    func getTVData() {
        Task {
            do {
                let genres = try await tvGenreRepository.fetchTVGenres()
                let topDetails = try await tvDetailsRepository.fetchTopRatedTVSeries(page: 1)
                let popularDetails = try await tvDetailsRepository.fetchPopularTVSeries(page: 1)
                let allDetails = topDetails + popularDetails
                
                var tvDetails: TVDetails?
                
                if let found = allDetails.first(where: { $0.id == tvId }) {
                    tvDetails = found
                } else {
                    // Если не нашли, запрашиваем напрямую по ID
                    print("MoviePagePresenter: movie with id \(tvId) not found in top/upcoming, fetching by id...")
                    tvDetails = try await tvDetailsRepository.fetchTVSeriesDetails(byId: tvId)
                }
                
                guard let tvDetails = tvDetails else {
                    print("MoviePagePresenter: movie with id \(tvId) not found")
                    return
                }
                
                currentTVMovie = tvDetails
                
                // 3) Корректно формируем viewModel — проверяем genreIDs или genres
                let genreIDs = tvDetails.genreIDs
                let tvDetailsVM = TVDetailsCellViewModel(
                    tvDetails: tvDetails,
                    tvGenres: genres.filter { genreIDs.contains($0.id) }
                )
                
                // 4) Загружаем постер
                var detailsVM = tvDetailsVM
                detailsVM.posterImage = await imageLoader.loadImage(
                    from: detailsVM.posterURL,
                    localName: tvDetails.posterPath,
                    isLocal: tvDetails.isLocalImage
                )
                
                // 5) Создаём секции
                let detailItem = TVPageCollectionItem.tvDetails(detailsVM)
                self.sections = [
                    TVPageCollectionSection(type: .posterTV, items: [detailItem]),
                    TVPageCollectionSection(type: .stackButtonsTV, items: []),
                    TVPageCollectionSection(type: .specificationTV, items: [detailItem]),
                    TVPageCollectionSection(type: .overviewTV, items: [detailItem]),
                    TVPageCollectionSection(type: .videoTV, items: []),
                    TVPageCollectionSection(type: .segmentedTabsTV, items: []),
                    TVPageCollectionSection(type: .dynamicContentTV, items: [])
                ]
                
                // 6) Отображаем базовую информацию
                await MainActor.run {
                    self.view?.setTitle(self.tvTitle)
                    self.view?.showTV(sections: self.sections)
                }
                
                // 7) Подгружаем трейлеры
                let videos = try await tvVideoRepository.fetchTVVideos(for: tvId)
                let limitedMovieVideo = Array(videos.prefix(3))
                self.videos = limitedMovieVideo
                
                // Загружаем превью через imageLoader
                let videoItems: [TVPageCollectionItem] = await limitedMovieVideo.asyncMap { video in
                    var videoVM = TVVideoCellViewModel(video: video, isLocal: false)
                    
                    videoVM.thumbnailImage = await imageLoader.loadImage(
                        from: videoVM.thumbnailURL,
                        localName: nil,
                        isLocal: false
                    )
                    return .tvVideo(videoVM)
                }
                
                if let indexSection = self.sections.firstIndex(where: { $0.type == .videoTV }) {
                    self.sections[indexSection].items = videoItems
                    
                    await MainActor.run {
                        self.view?.showTV(sections: self.sections)
                    }
                }
                
                // 8) Проверяем избранное
                let isFavorite = favoritesStorage.isFavorite(id: Int32(tvId))
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
                    let similar = try await tvSimilarRepository.fetchSimilarTVShows(for: tvId)
                    
                    let similarItems: [TVPageCollectionItem] = await similar.asyncMap { tvSimilar in
                        
                        var tvSimilarVM = TVSimilarCellViewModel(tvSimilar: tvSimilar)
                        
                        // Загружаем изображение через imageLoader (учитываем локальную картинку)
                        tvSimilarVM.posterImage = await imageLoader.loadImage(
                            from: tvSimilarVM.posterURL,
                            localName: tvSimilar.posterPath,
                            isLocal: tvSimilar.isLocalImage
                        )
                        return .tvSimilar(tvSimilarVM)
                    }
                    
                    if let dynamicSectionIndex = self.sections.firstIndex(where: { $0.type == .dynamicContentTV }) {
                        self.sections[dynamicSectionIndex].items = similarItems
                        
                        await MainActor.run {
                            self.view?.showTV(sections: self.sections)
                        }
                    }
                    
                case 1:
                    // Cast and Crew
                    let credits = try await tvCreditsRepository.fetchCredits(for: tvId)
                    
                    let castItems: [TVPageCollectionItem] = await credits.cast.asyncMap { castMember in
                        
                        var castVM = TVCastCellViewModel(cast: castMember)
                        
                        castVM.profileImage = await imageLoader.loadImage(
                            from: castVM.profileURL,
                            localName: castMember.profilePath,
                            isLocal: castMember.isLocalImage
                        )
                        return .tvCast(castVM)
                    }
                                                            
                    if let dynamicSectionIndex = self.sections.firstIndex(where: { $0.type == .dynamicContentTV }) {
                        self.sections[dynamicSectionIndex].items = castItems
                        
                        await MainActor.run {
                            self.view?.showTV(sections: self.sections)
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
        guard let movie = currentTVMovie else { return }
        let id = Int32(movie.id)
        
        if favoritesStorage.isFavorite(id: id) {
            favoritesStorage.removeFavorite(id: id)
            view?.updateFavoriteState(isFavorite: false)
        } else {
            favoritesStorage.addFavorite(
                id: id,
                title: movie.name,
                posterPath: movie.posterPath ?? "",
                voteAverage: movie.voteAverage ?? 0
            )
            view?.updateFavoriteState(isFavorite: true)
        }
    }
    
    //MARK: - didTapPlayTrailerButton
    
    func didTapPlayTrailerButton(videoVM: TVVideoCellViewModel) {
        guard let video = videos.first(where: { $0.id == videoVM.id }) else { return }
        let movieTitle = "\(video.name)"
        
        router.showTVTrailerPlayer(video: video, title: movieTitle)
        
        print("videoVM.id =", videoVM.id)
        print("videos =", videos.map { $0.id })
    }
    
    //MARK: - playPosterTrailer
    
    func playPosterTrailer() {
        guard let firstVideo = videos.first else { return }
        let tvTitle = "\(firstVideo.name)"
        
        router.showTVTrailerPlayer(video: firstVideo, title: tvTitle)
    }
    
    //MARK: - didSelectActor
    
    func didSelectActor(castVM: TVCastCellViewModel) {
        router.showActorPage(actorName: castVM.name, actorId: castVM.id )
    }
    
    //MARK: - didSelectSimilarMovie
    
    func didSelectSimilarMovie(_ tv: TVSimilarCellViewModel) {
        router.showTVPage(tvId: tv.id, tvTitle: tv.title)
    }
    
}

