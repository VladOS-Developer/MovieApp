//
//  TrailerPlayerPresenter.swift
//  MovieApp
//
//  Created by VladOS on 24.08.2025.
//

import UIKit

protocol TrailerPlayerPresenterProtocol: AnyObject {
        
    func viewDidLoad()
    func loadVideos()
    func didSelectMovieVideo(at index: Int)
    
    init(view: TrailerPlayerViewProtocol,
         imageLoader: ImageLoaderProtocol,
         movieVideoRepository: MovieVideoRepositoryProtocol,
         movieVideo: MovieVideo,
         movieTitle: String)

}

class TrailerPlayerPresenter: TrailerPlayerPresenterProtocol {
    
    private weak var view: TrailerPlayerViewProtocol?
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private var videos: [MovieVideo] = []
    private let initialVideo: MovieVideo
    private let movieTitle: String
    
    required init(view: TrailerPlayerViewProtocol,
                  imageLoader: ImageLoaderProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol,
                  movieVideo: MovieVideo,
                  movieTitle: String) {
        
        self.view = view
        self.imageLoader = imageLoader
        self.movieVideoRepository = movieVideoRepository
        self.initialVideo = movieVideo
        self.movieTitle = movieTitle
    
    }
    
    func viewDidLoad() {
        view?.setTitle(movieTitle)
        view?.loadVideo(with: initialVideo.key)
        loadVideos()
    }

    func loadVideos() {
        Task {
            do {
                // Загружаем трейлеры из трендовых фильмов
                let trendingVideos = try await movieVideoRepository.fetchTrendingMovieVideos()
                self.videos = trendingVideos
                
                // Формируем ViewModel с подгрузкой превью через imageLoader
                let trailerVM: [TrailerPlayerCellViewModel] = await trendingVideos.asyncMap { video in
                    
                    var trailerVM = TrailerPlayerCellViewModel(video: video, isLocal: false)
                    
                    if let url = trailerVM.thumbnailURL {
                        trailerVM.thumbnailImage = await imageLoader.loadImage(from: url, localName: nil, isLocal: false)
                    }
                    return trailerVM
                }
                
                // Обновление View на главном потоке
                await MainActor.run {
                    self.view?.showVideoList(trailerVM)
                }
                
            } catch {
                print("Ошибка загрузки трейлеров:", error)
            }
        }
    }
    
    func didSelectMovieVideo(at index: Int) {
        guard videos.indices.contains(index) else { return }
        let video = videos[index]
        view?.setTitle(video.name)
        view?.loadVideo(with: video.key)
    }
    
}
