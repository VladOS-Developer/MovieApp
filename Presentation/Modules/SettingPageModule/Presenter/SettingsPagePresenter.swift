//
//  SettingsPagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 13.10.2025.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    
    func didSelectChangePassword()
    func didSelectDeletePassword()
   
    init(view: SettingsPageViewProtocol,
         router: SettingsPageRouterProtocol,
         passcodeService: PasscodeService)
}

class SettingsPagePresenter: SettingsPresenterProtocol {
    
    private weak var view: SettingsPageViewProtocol?
    private let router: SettingsPageRouterProtocol
    private let passcodeService: PasscodeService
    
    required init(view: SettingsPageViewProtocol,
                  router: SettingsPageRouterProtocol,
                  passcodeService: PasscodeService) {
        
        self.view = view
        self.router = router
        self.passcodeService = passcodeService
    }
        
    func didSelectChangePassword() {
        router.showPasscodeModule(isSetting: true)
    }
    
    func didSelectDeletePassword() {
        passcodeService.deletePasscode()
        view?.showAlert(title: "Пароль удалён", message: "Установите новый код 🔐")
    }
    
}
