//
//  KeychainManager.swift
//  MovieApp
//
//  Created by VladOS on 04.08.2025.
//

import Foundation
import KeychainAccess

enum KeychainKeys: String {
    case passcode = "passcode1"
}

protocol KeychainManagerProtocol: AnyObject {
    func save(key: String, value: String)
    func load(key: String) -> Result <String , Error>
    func delete(key: String) -> Result<Void, Error>
}

class KeychainManager: KeychainManagerProtocol {
    
    private let keychain = Keychain(service: "PASSCODE")
    
    func save(key: String, value: String) {
        keychain[key] = value
    }

    func load(key: String) -> Result <String, Error> {
        do {
            let passcode = try keychain.getString(key) ?? ""
            return .success(passcode)
        } catch {
            print("[Keychain] Failed to load key \(key): \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    func delete(key: String) -> Result <Void, Error> {
        do {
            try keychain.remove(key)
            return .success(())
        } catch {
            print("[Keychain] Failed to delete key \(key): \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
}
