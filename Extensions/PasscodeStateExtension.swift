//
//  PasscodeStateExtension.swift
//  MovieApp
//
//  Created by VladOS on 01.08.2025.
//

import UIKit

extension PasscodeState {
    
    var passcodeLabel: String {
        switch self {
        case .inputPasscode: return "Введите код"
        case .wrongPasscode: return "Неверный код"
        case .setNewPasscode: return "Установить код"
        case .repeatPasscode: return "Повторите код"
        case .codeMismatch: return "Коды не совпадают"
        }
    }
    
    var labelColor: UIColor {
        switch self {
        case .wrongPasscode, .codeMismatch: return .appRed
        default: return .appWhite
        }
    }
}
