//
//  TrailerPlayerView.swift
//  MovieApp
//
//  Created by VladOS on 24.08.2025.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol TrailerPlayerViewProtocol: AnyObject {
    func loadVideo(with key: String)
    func setTitle(_ text: String)
}

class TrailerPlayerView: UIViewController {
        
    var presenter: TrailerPlayerPresenterProtocol!
    
    private let playerView = YTPlayerView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarWithBackButton(title: title, backAction: #selector(didTapBack))
        view.backgroundColor = .black
        setupPlayerView()
        presenter.viewDidLoad()
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupPlayerView() {
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9.0/16.0) // 16:9
        ])
    }
}

extension TrailerPlayerView: TrailerPlayerViewProtocol {
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
    
    func loadVideo(with key: String) {
        playerView.load(withVideoId: key, playerVars: ["playsinline": 1,    // в приложении, а не на весь экран
                                                       "autoplay": 1,       // сразу стартует
                                                       "modestbranding": 1, // убирает часть логотипов
                                                       "rel": 0             // не показывает похожие видео в конце
                                                      ])
    }
}
