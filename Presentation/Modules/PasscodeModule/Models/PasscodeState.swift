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
        case .inputPasscode: return "Enter code"
        case .wrongPasscode: return "Invalid code ❌"
        case .setNewPasscode: return "Install code"
        case .repeatPasscode: return "Repeat the code"
        case .codeMismatch: return "The codes do not match ❌"
        case .successChanged: return "Password changed successfully ✅"
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

