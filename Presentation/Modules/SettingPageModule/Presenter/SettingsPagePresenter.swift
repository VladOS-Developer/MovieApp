//
//  SettingsPagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 13.10.2025.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    
    init(view: SettingsViewProtocol)
    func viewDidLoad()
}

class SettingsPagePresenter: SettingsPresenterProtocol {
    
    private weak var view: SettingsViewProtocol?
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
    
    
}
