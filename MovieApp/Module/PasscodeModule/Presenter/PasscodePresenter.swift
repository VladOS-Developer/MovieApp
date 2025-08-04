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
    
    init (view: PasscodeViewProtocol)
}

class PasscodePresenter: PasscodePresenterProtocol {
    
    weak var view: PasscodeViewProtocol?
    
    private let state: PasscodeState
    
    var templatePasscode: [Int]?
    
    var passcode: [Int]
    
    required init(view: PasscodeViewProtocol) {
        self.view = view
    }
    
    
    func enterPasscode(number: Int) {
        <#code#>
    }
    
    func removeLastItemInPasscode() {
        <#code#>
    }
    
    func setNewPasscode() {
        <#code#>
    }
    
    func checkPasscode() {
        <#code#>
    }
    
    func clearPasscode(state: PasscodeState) {
        <#code#>
    }
    
    
}
