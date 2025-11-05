//
//  TVTrailerPlayerPresenter.swift
//  MovieApp
//
//  Created by VladOS on 05.11.2025.
//

import UIKit

protocol TVTrailerPlayerPresenterProtocol: AnyObject {
    func viewDidLoad()
    func loadVideos()
    func didSelectVideo(at index: Int)
    
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
    
    func viewDidLoad() {
        view?.setTitle(tvTitle)
        view?.loadVideo(with: initialVideo.key)
        loadVideos()
    }

    func loadVideos() {
        Task {
            do {
                let trendingVideos = try await tvVideoRepository.fetchTrendingTVVideos()
                self.videos = trendingVideos
                
                let trailerVM: [TrailerPlayerCellViewModel] = await trendingVideos.asyncMap { video in
                    var vm = TrailerPlayerCellViewModel(video: video, isLocal: false)
                    if let url = vm.thumbnailURL {
                        vm.thumbnailImage = await imageLoader.loadImage(from: url, localName: nil, isLocal: false)
                    }
                    return vm
                }
                
                await MainActor.run {
                    self.view?.showVideoList(trailerVM)
                }
            } catch {
                print("Ошибка загрузки ТВ-трейлеров:", error)
            }
        }
    }
    
    func didSelectVideo(at index: Int) {
        guard videos.indices.contains(index) else { return }
        let video = videos[index]
        view?.setTitle(video.name)
        view?.loadVideo(with: video.key)
    }
}
