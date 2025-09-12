//
//  TrailerPlayerPresenter.swift
//  MovieApp
//
//  Created by VladOS on 24.08.2025.
//

import UIKit

protocol TrailerPlayerPresenterProtocol: AnyObject {
    func viewDidLoad()
    init(view: TrailerPlayerViewProtocol,
         video: MovieVideo,
         movieTitle: String)
}

class TrailerPlayerPresenter {
    private weak var view: TrailerPlayerViewProtocol?
    private let video: MovieVideo
    private let movieTitle: String
    
    required init(view: TrailerPlayerViewProtocol,
                  video: MovieVideo,
                  movieTitle: String) {
        
        self.view = view
        self.video = video
        self.movieTitle = movieTitle
    }
}

extension TrailerPlayerPresenter: TrailerPlayerPresenterProtocol {
    
    func viewDidLoad() {
        view?.setTitle(movieTitle)
        view?.loadVideo(with: video.key)
    }
}
