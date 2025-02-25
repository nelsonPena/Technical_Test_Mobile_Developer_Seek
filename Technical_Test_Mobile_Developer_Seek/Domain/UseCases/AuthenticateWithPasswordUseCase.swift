//
//  AuthenticateWithPasswordUseCase.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation

class AuthenticateWithPasswordUseCase {
    private let repository: AuthRepository

    init(repository: AuthRepository) {
        self.repository = repository
    }

    func execute(password: String) -> Bool {
        return repository.authenticateWithPassword(password: password)
    }
}
