//
//  MoviePageView.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import UIKit

protocol MoviePageViewProtocol: AnyObject {
    
}

class MoviePageView: UIViewController {
    
    var presenter: MoviePagePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension MoviePageView: MoviePageViewProtocol {
    
}
