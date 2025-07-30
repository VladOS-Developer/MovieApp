//
//  PasscodePresenter.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol PasscodePresenterProtocol: AnyObject {
    
    init (view: PasscodeViewProtocol)
}

class PasscodePresenter: PasscodePresenterProtocol {
    
    weak var view: PasscodeViewProtocol?
    
    required init(view: PasscodeViewProtocol) {
        self.view = view
    }
    
}
