//
//  AuthenticateWithBiometricsUseCase.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation

class AuthenticateWithBiometricsUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Bool) -> Void) {
        repository.authenticateWithBiometrics { success in
            completion(success)
        }
    }
}
