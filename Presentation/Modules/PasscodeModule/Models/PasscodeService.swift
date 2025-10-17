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
        case .failure(let error):
            print("[PasscodeService] getCurrentState error: \(error.localizedDescription)")
            return .setNewPasscode
        }
    }
    
    func save(passcode: [Int]) {
        let codeString = passcode.map(String.init).joined()
        print("[PasscodeService] Saving passcode ✅")
        keychainManager.save(key: KeychainKeys.passcode.rawValue, value: codeString)
    }
    
    func loadPasscode() -> String? {
        switch keychainManager.load(key: KeychainKeys.passcode.rawValue) {
            
        case .success(let code):
            return code
        case .failure(let error):
            print("[PasscodeService] loadPasscode error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deletePasscode() {
        switch keychainManager.delete(key: KeychainKeys.passcode.rawValue) {
        case .success:
            print("[PasscodeService] Passcode deleted successfully")
        case .failure(let error):
            print("[PasscodeService] Failed to delete passcode: \(error.localizedDescription)")
        }
    }
}
