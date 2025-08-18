//
//  TrailerPlayerView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
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
    }
    
}

extension TrailerPlayerView: TrailerPlayerViewProtocol {
    
}
