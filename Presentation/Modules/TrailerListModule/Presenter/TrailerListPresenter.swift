//
//  TrailerListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol TrailerListPresenterProtocol: AnyObject {
    func loadTopVideos()
    func didTapTrailerListButton(videoVM: TrailerVideoCellViewModel)
    
    init(view: TrailerListViewProtocol,
         router: TrailerListRouterProtocol,
         movieVideoRepository: MovieVideoRepositoryProtocol)
    
}

class TrailerListPresenter {
    private weak var view: TrailerListViewProtocol?
    private let router: TrailerListRouterProtocol
    
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private var videos: [MovieVideo] = []
    
    required init(view: TrailerListViewProtocol,
                  router: TrailerListRouterProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol) {
        
        self.view = view
        self.router = router
        self.movieVideoRepository = movieVideoRepository
    }
    
    func loadTopVideos() {
        Task {
            do {
                let videos = try await movieVideoRepository.fetchTopVideos()
                self.videos = videos
                
                let viewModels = videos.map { TrailerVideoCellViewModel(video: $0, isLocal: false) }
                
                await MainActor.run {
                    self.view?.showVideos(viewModels)
                }
            } catch {
                print("Ошибка загрузки топовых видео: \(error)")
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



