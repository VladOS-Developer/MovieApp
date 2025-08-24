//
//  TrailerPlayerView.swift
//  MovieApp
//
//  Created by VladOS on 24.08.2025.
//

import UIKit

protocol TrailerPlayerViewProtocol: AnyObject {
    
}

class TrailerPlayerView: UIViewController {
    
    var presenter: TrailerPlayerPresenterProtocol!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Player"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

extension TrailerPlayerView: TrailerPlayerViewProtocol {
    
}
