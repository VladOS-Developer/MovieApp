//
//  TVEpisodePlayerPresenter.swift
//  MovieApp
//
//  Created by VladOS on 11.11.2025.
//

import UIKit

protocol TVEpisodePlayerPresenterProtocol: AnyObject {
    func viewEpisodeDidLoad()
    func loadEpisodeVideos()
    func didSelectEpisodeVideo(at index: Int)
    
    init(view: TrailerPlayerViewProtocol,
         imageLoader: ImageLoaderProtocol,
         tvEpisodeVideoRepository: TVSeasonRepositoryProtocol,
         
         tvEpisodeVideo: TVEpisodeVideo,
         tvTitle: String,
         tvId: Int)
}

final class TVEpisodePlayerPresenter: TVEpisodePlayerPresenterProtocol {
    
    private weak var view: TrailerPlayerViewProtocol?
    private let imageLoader: ImageLoaderProtocol
    private let tvEpisodeVideoRepository: TVSeasonRepositoryProtocol
    
    
    private var videos: [TVEpisodeVideo] = []
    private let initialVideo: TVEpisodeVideo
    private let tvTitle: String
    private let tvId: Int

    required init(view: TrailerPlayerViewProtocol,
                  imageLoader: ImageLoaderProtocol,
                  tvEpisodeVideoRepository: TVSeasonRepositoryProtocol,
                  
                  tvEpisodeVideo: TVEpisodeVideo,
                  tvTitle: String,
                  tvId: Int) {
        
        self.view = view
        self.imageLoader = imageLoader
        self.tvEpisodeVideoRepository = tvEpisodeVideoRepository
        self.initialVideo = tvEpisodeVideo
        self.tvTitle = tvTitle
        self.tvId = tvId
    }
    
    func viewEpisodeDidLoad() {
        view?.setTitle(tvTitle)
        view?.loadVideo(with: initialVideo.key)
        loadEpisodeVideos()
    }

    func loadEpisodeVideos() {
        Task {
            do {
                let episodeVideos = try await tvEpisodeVideoRepository.fetchEpisodeVideos(for: tvId)
                self.videos = episodeVideos
                
                let trailerVM: [TrailerPlayerCellViewModel] = await episodeVideos.asyncMap { video in
                    
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
    
    func didSelectEpisodeVideo(at index: Int) {
        guard videos.indices.contains(index) else { return }
        let video = videos[index]
        view?.setTitle(video.name)
        view?.loadVideo(with: video.key)
    }
}

