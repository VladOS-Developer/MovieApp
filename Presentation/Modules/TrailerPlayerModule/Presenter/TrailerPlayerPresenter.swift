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
    func didSelectVideo(at index: Int)

    init(view: TrailerPlayerViewProtocol,
         movieVideoRepository: MovieVideoRepositoryProtocol,
         video: MovieVideo,
         movieTitle: String)
}

class TrailerPlayerPresenter {
    private weak var view: TrailerPlayerViewProtocol?
    
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    
    private let initialVideo: MovieVideo
    private var videos: [MovieVideo] = []
    private let movieTitle: String

    required init(view: TrailerPlayerViewProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol,
                  video: MovieVideo,
                  movieTitle: String) {
        
        self.view = view
        self.movieVideoRepository = movieVideoRepository
        self.initialVideo = video
        self.movieTitle = movieTitle
    }
}

extension TrailerPlayerPresenter: TrailerPlayerPresenterProtocol {

    func viewDidLoad() {
        view?.setTitle(movieTitle)
        view?.loadVideo(with: initialVideo.key)
        loadVideos()
    }

    func loadVideos() {
        Task {
            do {
                // Можно заменить на fetchMovieVideo(for: movieId) если будут нужны связанные видео
                let items = try await movieVideoRepository.fetchTopVideos()
                self.videos = items
                
                let viewModels = items.map { TrailerVideoCellViewModel(video: $0, isLocal: false) }
                await MainActor.run {
                    self.view?.showVideoList(viewModels)
                }
            } catch {
                print("Ошибка загрузки видео в плеер: \(error)")
            }
        }
    }

    func didSelectVideo(at index: Int) {
        guard videos.indices.contains(index) else { return }
        
        let videos = videos[index]
        view?.setTitle(videos.name)
        view?.loadVideo(with: videos.key)
    }
}
