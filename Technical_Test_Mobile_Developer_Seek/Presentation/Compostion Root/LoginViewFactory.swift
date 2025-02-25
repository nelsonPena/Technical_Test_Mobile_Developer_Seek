//
//  LoginViewFactory.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation
import SwiftUI

class LoginViewFactory {
    
    func build() -> LoginView? {
        guard let viewModel = createViewModel() else { return nil }
        return LoginView(viewModel: viewModel)
    }
    
    private func createViewModel() -> LoginViewModel? {
        LoginViewModel(authRepository: createAuthRepository(), keyUseCase: createKeychainUseCase())
    }
    
    private func createAuthRepository() -> AuthRepository {
        let biometricManager = BiometricAuthManager()
        return AuthRepositoryImpl(biometricAuthManager: biometricManager, keychainManager: KeychainManager.shared)
    }
    
    private func createKeychainUseCase() -> KeychainUseCase {
        return KeychainUseCaseImpl(repository: createKeychainRepository())
    }
    
    private func createKeychainRepository() -> KeychainRepository {
        return KeychainRepositoryImpl()
    }
}
