//
//  TVTrailerPlayerPresenter.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

protocol TVTrailerPlayerPresenterProtocol: AnyObject {
    func viewTVDidLoad()
    func loadTVVideos()
    func didSelectTVVideo(at index: Int)
    
    init(view: TrailerPlayerViewProtocol,
         imageLoader: ImageLoaderProtocol,
         tvVideoRepository: TVVideoRepositoryProtocol,
         tvVideo: TVVideo,
         tvTitle: String)
}

final class TVTrailerPlayerPresenter: TVTrailerPlayerPresenterProtocol {
    
    private weak var view: TrailerPlayerViewProtocol?
    private let tvVideoRepository: TVVideoRepositoryProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private var videos: [TVVideo] = []
    private let initialVideo: TVVideo
    private let tvTitle: String
    
    required init(view: TrailerPlayerViewProtocol,
                  imageLoader: ImageLoaderProtocol,
                  tvVideoRepository: TVVideoRepositoryProtocol,
                  tvVideo: TVVideo,
                  tvTitle: String) {
        self.view = view
        self.imageLoader = imageLoader
        self.tvVideoRepository = tvVideoRepository
        self.initialVideo = tvVideo
        self.tvTitle = tvTitle
    }
    
    func viewTVDidLoad() {
        view?.setTitle(tvTitle)
        view?.loadVideo(with: initialVideo.key)
        loadTVVideos()
    }

    func loadTVVideos() {
        Task {
            do {
                let trendingVideos = try await tvVideoRepository.fetchTrendingTVVideos()
                self.videos = trendingVideos
                
                let trailerVM: [TrailerPlayerCellViewModel] = await trendingVideos.asyncMap { video in
                    var trailerVM = TrailerPlayerCellViewModel(video: video, isLocal: false)
                    if let url = trailerVM.thumbnailURL {
                        trailerVM.thumbnailImage = await imageLoader.loadImage(from: url, localName: nil, isLocal: false)
                    }
                    return trailerVM
                }
                
                await MainActor.run {
                    self.view?.showVideoList(trailerVM)
                }
            } catch {
                print("Ошибка загрузки ТВ-трейлеров:", error)
            }
        }
    }
    
    func didSelectTVVideo(at index: Int) {
        guard videos.indices.contains(index) else { return }
        let video = videos[index]
        view?.setTitle(video.name)
        view?.loadVideo(with: video.key)
    }
}
