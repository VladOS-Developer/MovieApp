//
//  SettingsPagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 13.10.2025.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func didSelectChangePassword()
    func didSelectDeletePassword()
   
    init(view: SettingsPageViewProtocol, service: PasscodeService)
}

class SettingsPagePresenter: SettingsPresenterProtocol {
    
    private weak var view: SettingsPageViewProtocol?
    private let service: PasscodeService
    
    required init(view: SettingsPageViewProtocol, service: PasscodeService) {
        self.view = view
        self.service = service
    }
    
    func viewDidLoad() { }
    
    func didSelectChangePassword() {
        view?.openPasscodeModule(isSetting: true)
    }
    
    func didSelectDeletePassword() {
        service.deletePasscode()
        view?.showAlert(title: "Пароль удалён", message: "Установите новый код 🔐")
    }
    
}
