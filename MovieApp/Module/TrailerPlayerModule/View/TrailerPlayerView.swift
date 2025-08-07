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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        title = "2"
    }
    

}

extension TrailerPlayerView: TrailerPlayerViewProtocol {
    
}
