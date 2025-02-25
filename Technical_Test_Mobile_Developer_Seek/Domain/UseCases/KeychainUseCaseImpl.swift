//
//  KeychainUseCaseImpl.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation

final class KeychainUseCaseImpl: KeychainUseCase {
   
    
    private let repository: KeychainRepository

    init(repository: KeychainRepository) {
        self.repository = repository
    }

    func save(value: String, forKey key: String) {
        repository.save(value: value, forKey: key)
    }
    
    func get(forKey key: String) -> String? {
        repository.get(forKey: key)
    }
    
    func delete(forKey key: String) {
        repository.delete(forKey: key)
    }
}
