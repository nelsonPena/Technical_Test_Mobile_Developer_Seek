//
//  AuthViewModel.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    
    private var password: String = ""
    var onShowAlert: ((String, AlertType) -> Void)?
    private let authenticateWithBiometricsUseCase: AuthenticateWithBiometricsUseCase
    private let authenticateWithPasswordUseCase: AuthenticateWithPasswordUseCase
    private let keyUseCase: KeychainUseCase
    @Published var showPasswordPrompt = false
    @Published var showPasswordModal = false
    @Published var isAuthenticated: Bool = false {
        didSet {
            UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated")
        }
    }
    
    init(authRepository: AuthRepository,
         keyUseCase: KeychainUseCase) {
        self.authenticateWithBiometricsUseCase = AuthenticateWithBiometricsUseCase(repository: authRepository)
        self.authenticateWithPasswordUseCase = AuthenticateWithPasswordUseCase(repository: authRepository)
        self.keyUseCase = keyUseCase
    }
    
    func authenticate() {
        authenticateWithBiometricsUseCase.execute { [weak self] success in
            guard let self else { return }
            if success {
                self.isAuthenticated = true
            } else {
                onShowAlert?("❌ Falling facial uses code", .error)
                guard let _ = keyUseCase.get(forKey: "password") else {
                    self.showPasswordModal = true
                    return
                }
                self.showPasswordPrompt = true
            }
        }
    }
    
    func authenticateWithPassword(password: String) {
        if authenticateWithPasswordUseCase.execute(password: password) {
            isAuthenticated = true
        } else {
            onShowAlert?("❌ Incorrect password", .info)
        }
    }
    
    func savePassword(_ password: String) {
        keyUseCase.save(value: password, forKey: "password")
    }
}
