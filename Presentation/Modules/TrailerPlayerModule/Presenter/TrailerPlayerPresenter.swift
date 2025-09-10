//
//  TrailerPlayerPresenter.swift
//  MovieApp
//
//  Created by VladOS on 24.08.2025.
//

import UIKit

protocol TrailerPlayerPresenterProtocol: AnyObject {
    func viewDidLoad()
    init(view: TrailerPlayerViewProtocol, video: MovieVideo)
    
}

class TrailerPlayerPresenter {
    private weak var view: TrailerPlayerViewProtocol?
    private let video: MovieVideo
    
    required init(view: TrailerPlayerViewProtocol, video: MovieVideo) {
        self.view = view
        self.video = video
    }
}

extension TrailerPlayerPresenter: TrailerPlayerPresenterProtocol {
    
    func viewDidLoad() {
        view?.loadVideo(with: video.key) // или video.youtubeKey если сделал extension
//        view?.loadVideo(with: video.youtubeKey)
    }
    
    
}
