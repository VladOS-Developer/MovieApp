//
//  TrailerListPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol TrailerListPresenterProtocol: AnyObject {
    init(view: TrailerListViewProtocol)
    
}

class TrailerListPresenter {
    private weak var view: TrailerListViewProtocol?
    
    required init(view: TrailerListViewProtocol) {
        self.view = view
    }
    
}

extension TrailerListPresenter: TrailerListPresenterProtocol {
    
}
