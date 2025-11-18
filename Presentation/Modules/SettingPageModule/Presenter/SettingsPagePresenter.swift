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
   
    init(view: SettingsPageViewProtocol, passcodeService: PasscodeService)
}

class SettingsPagePresenter: SettingsPresenterProtocol {
    
    private weak var view: SettingsPageViewProtocol?
    private let passcodeService: PasscodeService
    
    required init(view: SettingsPageViewProtocol, passcodeService: PasscodeService) {
        self.view = view
        self.passcodeService = passcodeService
    }
    
    func viewDidLoad() { }
    
    func didSelectChangePassword() {
        view?.openPasscodeModule(isSetting: true)
    }
    
    func didSelectDeletePassword() {
        passcodeService.deletePasscode()
        view?.showAlert(title: "Пароль удалён", message: "Установите новый код 🔐")
    }
    
}
