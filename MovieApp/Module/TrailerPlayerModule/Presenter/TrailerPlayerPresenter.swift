//
//  TrailerPlayerPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol TrailerPlayerPresenterProtocol: AnyObject {
    init(view: TrailerPlayerViewProtocol)
}

class TrailerPlayerPresenter {
    weak var view: TrailerPlayerViewProtocol?
    
    required init(view: TrailerPlayerViewProtocol) {
        self.view = view
    }
    
}

extension TrailerPlayerPresenter: TrailerPlayerPresenterProtocol {
    
}
