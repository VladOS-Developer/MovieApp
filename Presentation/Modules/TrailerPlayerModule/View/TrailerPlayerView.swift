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
}

class TrailerPlayerView: UIViewController {
        
    var presenter: TrailerPlayerPresenterProtocol!
    
    private let playerView = YTPlayerView()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerView()
        presenter.viewDidLoad()
    }
    
    private func setupPlayerView() {
        view.addSubview(playerView)
        title = "Player"
        
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
    
    func loadVideo(with key: String) {
        playerView.load(withVideoId: key, playerVars: ["playsinline": 1, "autoplay": 1])
    }
    
    
}
