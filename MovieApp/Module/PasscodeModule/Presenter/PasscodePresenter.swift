//
//  PasscodePresenter.swift
//  MovieApp
//
//  Created by VladOS on 30.07.2025.
//

import UIKit

protocol PasscodePresenterProtocol: AnyObject {
    var passcode: [Int] { get set }
    var templatePasscode: [Int]? { get set }
    
    func enterPasscode(number: Int)             // запись числа в passcode
    func removeLastItemInPasscode()             // удаление последнего элемента
    func setNewPasscode()                       // установка нового пароля / изменить старый
    func checkPasscode()                        // проверка пароля
    func clearPasscode(state: PasscodeState)    // удалить пароль
    
    init (view: PasscodeViewProtocol, service: PasscodeService, sceneDelegate: SceneDelegateProtocol)
}

class PasscodePresenter: PasscodePresenterProtocol {
    
    private weak var view: PasscodeViewProtocol?
    weak var sceneDelegate: SceneDelegateProtocol?
    
    private let service: PasscodeService
    private let state: PasscodeState
    
    var templatePasscode: [Int]?
    
    var passcode: [Int] = [] {
        didSet {
            if passcode.count == 4 {
                switch state {
                case .inputPasscode: self.checkPasscode()
                case .setNewPasscode: self.setNewPasscode()
                default: break
                }
            }
        }
    }
    
    required init(view: PasscodeViewProtocol, service: PasscodeService, sceneDelegate: SceneDelegateProtocol) {
        self.view = view
        self.service = service
        self.state = service.getCurrentState()
        self.sceneDelegate = sceneDelegate
        
        view.passcodeState(state: state)
    }
    
    
    func enterPasscode(number: Int) {
        guard passcode.count < 4 else { return }
        passcode.append(number)
        view?.enterCode(code: passcode)
    }
    
    func removeLastItemInPasscode() {
        guard !passcode.isEmpty else { return }
        passcode.removeLast()
        view?.enterCode(code: passcode)
    }
    
    func setNewPasscode() {
        if let template = templatePasscode {
            if passcode == template{
                service.save(passcode: passcode)
                print("Passcode saved")
                // Route to next module
                self.sceneDelegate?.startMainScreen()
            } else {
                view?.passcodeState(state: .codeMismatch)
            }
        } else {
            templatePasscode = passcode
            clearPasscode(state: .repeatPasscode)
        }
    }
    
    func checkPasscode() {
        guard let stored = service.loadPasscode() else {
            view?.passcodeState(state: .wrongPasscode)
            return
        }
        if passcode == stored.digits {
            print("Correct code")
            // Route to next module
            self.sceneDelegate?.startMainScreen()
        } else {
            clearPasscode(state: .wrongPasscode)
        }
    }
    
    func clearPasscode(state: PasscodeState) {
        self.passcode = []
        self.view?.enterCode(code: [])
        self.view?.passcodeState(state: state)
    }
    
    
}
