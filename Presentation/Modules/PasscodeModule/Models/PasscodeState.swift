//
//  PasscodeState.swift
//  MovieApp
//
//  Created by VladOS on 01.08.2025.
//

import UIKit

enum PasscodeState {
    case inputPasscode
    case wrongPasscode
    case setNewPasscode
    case repeatPasscode
    case codeMismatch
    case successChanged
}

extension PasscodeState {
    
    var passcodeLabel: String {
        switch self {
        case .inputPasscode: return "Введите код"
        case .wrongPasscode: return "Неверный код ❌"
        case .setNewPasscode: return "Установить код"
        case .repeatPasscode: return "Повторите код"
        case .codeMismatch: return "Коды не совпадают ❌"
        case .successChanged: return "Пароль успешно изменён ✅"
        }
    }
    
    var labelColor: UIColor {
        switch self {
        case .wrongPasscode, .codeMismatch: return .systemRed
        case .successChanged: return .systemGreen
        default: return .appWhite
        }
    }
}

