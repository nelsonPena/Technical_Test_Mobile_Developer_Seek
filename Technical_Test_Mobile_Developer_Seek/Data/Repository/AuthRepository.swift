//
//  AuthRepository.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation

protocol AuthRepository {
    func authenticateWithBiometrics(completion: @escaping (Bool) -> Void)
    func authenticateWithPassword(password: String) -> Bool
}

class AuthRepositoryImpl: AuthRepository {
    private let biometricAuthManager: BiometricAuthManager
    private var keychainManager = KeychainManager.shared

    init(biometricAuthManager: BiometricAuthManager,
         keychainManager: KeychainManager) {
        self.biometricAuthManager = biometricAuthManager
        self.keychainManager = keychainManager
    }

    func authenticateWithBiometrics(completion: @escaping (Bool) -> Void) {
        biometricAuthManager.authenticateWithBiometrics { success, _ in
            completion(success)
        }
    }

    func authenticateWithPassword(password: String) -> Bool {
        return password == keychainManager.get(forKey: "password")
    }
}
