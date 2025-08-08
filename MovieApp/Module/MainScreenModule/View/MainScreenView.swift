//
//  MainScreenView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func showMovies(sections: [CollectionSection])
}

class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    
    private var sections: [CollectionSection] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainScreenView: MainScreenViewProtocol {
    func showMovies(sections: [CollectionSection]) {
        self.sections = sections
        // collectionView.reloadData()
    }
    
    
}
