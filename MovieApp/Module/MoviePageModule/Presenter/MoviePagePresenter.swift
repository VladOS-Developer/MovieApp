//
//  MoviePagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 18.08.2025.
//

import Foundation

protocol MoviePagePresenterProtocol: AnyObject {
    init(view: MoviePageViewProtocol, service: MovieServiceProtocol)
    func viewDidLoad()
}

class MoviePagePresenter: MoviePagePresenterProtocol {
    
    private weak var view: MoviePageViewProtocol?
    private let service: MovieServiceProtocol
    
    required init(view: MoviePageViewProtocol, service: MovieServiceProtocol) {
        self.view = view
        self.service = service
    }
    
    func viewDidLoad() {
        
    }
    
}
