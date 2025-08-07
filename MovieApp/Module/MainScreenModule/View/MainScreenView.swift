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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        title = "1"
    }
}

extension MainScreenView: MainScreenViewProtocol {
    
}
