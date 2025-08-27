//
//  PasscodeService.swift
//  MovieApp
//
//  Created by VladOS on 04.08.2025.
//

import UIKit

class PasscodeService {
    
    private let keychainManager: KeychainManagerProtocol
    
    init(keychainManager: KeychainManagerProtocol) {
        self.keychainManager = keychainManager
    }
    
    func getCurrentState() -> PasscodeState {
        switch keychainManager.load(key: KeychainKeys.passcode.rawValue) {
            
        case .success(let code):
            return code.isEmpty ? .setNewPasscode : .inputPasscode
        case .failure(_):
            return .setNewPasscode
        }
    }
    
    func save(passcode: [Int]) {
        let codeString = passcode.map(String.init).joined()
        print("Saving:" , codeString)
        keychainManager.save(key: KeychainKeys.passcode.rawValue, value: codeString)
    }
    
    func loadPasscode() -> String? {
        switch keychainManager.load(key: KeychainKeys.passcode.rawValue) {
            
        case .success(let code):
            return code
        case .failure(_):
            return nil
        }
    }
    
    func clear() {
        keychainManager.save(key: KeychainKeys.passcode.rawValue, value: "")
    }
}
