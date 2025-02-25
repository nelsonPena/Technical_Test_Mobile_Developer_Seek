//
//  KeychainRepositoryImpl.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation

final class KeychainRepositoryImpl: KeychainRepository {
    
    private let keychainManager = KeychainManager.shared

    func save(value: String, forKey key: String) {
        keychainManager.save(value: value, forKey: key)
    }

    func get(forKey key: String) -> String? {
        return keychainManager.get(forKey: key)
    }

    func delete(forKey key: String) {
        keychainManager.delete(forKey: key)
    }
}
