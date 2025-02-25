//
//  KeychainRepository.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation

protocol KeychainRepository {
    func save(value: String, forKey key: String)
    func get(forKey key: String) -> String?
    func delete(forKey key: String)
}
