//
//  TrailerListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol TrailerListPresenterProtocol: AnyObject {
    func loadTrendingVideos()
    func didTapTrailerListButton(videoVM: TrailerVideoCellViewModel)
    
    init(view: TrailerListViewProtocol,
         imageLoader: ImageLoaderProtocol,
         router: TrailerListRouterProtocol,
         movieVideoRepository: MovieVideoRepositoryProtocol)
}

class TrailerListPresenter {
    
    private weak var view: TrailerListViewProtocol?
    private let imageLoader: ImageLoaderProtocol
    private let router: TrailerListRouterProtocol
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private var videos: [MovieVideo] = []
    
    required init(view: TrailerListViewProtocol,
                  imageLoader: ImageLoaderProtocol,
                  router: TrailerListRouterProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol) {
        
        self.view = view
        self.router = router
        self.movieVideoRepository = movieVideoRepository
        self.imageLoader = imageLoader
    }
    
    func loadTrendingVideos() {
        Task {
            do {
                // Загружаем трейлеры из трендовых фильмов
                let trendingVideos = try await movieVideoRepository.fetchTrendingVideos()
                self.videos = trendingVideos
                
                // Формируем ViewModel с подгрузкой превью через imageLoader
                let trailerVM: [TrailerVideoCellViewModel] = await trendingVideos.asyncMap { video in
                    
                    var trailerVM = TrailerVideoCellViewModel(video: video, isLocal: false)
                    
                    if let url = trailerVM.thumbnailURL {
                        trailerVM.thumbnailImage = await imageLoader.loadImage(from: url, localName: nil, isLocal: false)
                    }
                    return trailerVM
                }
                
                // Обновление View на главном потоке
                await MainActor.run {
                    self.view?.showVideos(trailerVM)
                }
                
            } catch {
                print("Ошибка загрузки трейлеров:", error)
            }
        }
    }
    
    
}

extension TrailerListPresenter: TrailerListPresenterProtocol {
    
    func didTapTrailerListButton(videoVM: TrailerVideoCellViewModel) {
        guard let video = videos.first(where: { $0.id == videoVM.id }) else { return }
        let movieTitle = "\(video.name)"
        
        router.showTrailerPlayer(video: video, movieTitle: movieTitle)
        
        print("videoVM.id =", videoVM.id)
        print("videos =", videos.map { $0.id })
    }
}




