//
//  MainScreenView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    
}

class MainScreenView: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "1"
    }
}

extension MainScreenView: MainScreenViewProtocol {
    
}
