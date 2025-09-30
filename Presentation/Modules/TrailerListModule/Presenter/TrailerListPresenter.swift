//
//  TrailerListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol TrailerListPresenterProtocol: AnyObject {
    func loadTopVideos()
    
    init(view: TrailerListViewProtocol,
         movieVideoRepository: MovieVideoRepositoryProtocol)
    
}

class TrailerListPresenter {
    private weak var view: TrailerListViewProtocol?
    
    private let movieVideoRepository: MovieVideoRepositoryProtocol
    private var videos: [MovieVideo] = []
    
    required init(view: TrailerListViewProtocol,
                  movieVideoRepository: MovieVideoRepositoryProtocol) {
        
        self.view = view
        self.movieVideoRepository = movieVideoRepository
        print("Presenter инициализирован, view: \(view)")
    }
    
    func loadTopVideos() {
        Task {
            do {
                let videos = try await movieVideoRepository.fetchTopVideos()
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
    
}
