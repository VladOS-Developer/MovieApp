//
//  MovieListView.swift
//  MovieApp
//
//  Created by VladOS on 15.08.2025.
//

import UIKit

protocol MovieListViewProtocol: AnyObject {
    
}

class MovieListView: UIViewController {
    
    var presenter: MovieListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
