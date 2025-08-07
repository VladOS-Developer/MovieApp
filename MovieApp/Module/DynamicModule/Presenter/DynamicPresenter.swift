//
//  DynamicPresenter.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol DynamicPresenterProtocol: AnyObject {
    init(view: DynamicViewProtocol)
}

class DynamicPresenter {
    
    weak var view: DynamicViewProtocol?
    
    required init(view: DynamicViewProtocol) {
        self.view = view
    }
}

extension DynamicPresenter: DynamicPresenterProtocol {
    
}
