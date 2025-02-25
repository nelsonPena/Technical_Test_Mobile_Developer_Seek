//
//  DataError.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//

import Foundation

enum DataError: Error {
    case badServerResponse
    case timeOut
    case generic
    case noData
    case errorSaveData
    case errorDeleteData
    
    func mapper() -> DomainError {
        switch self {
        case .badServerResponse:
            return .generic
        case .timeOut:
            return .generic
        case .generic:
            return .generic
        case .noData:
            return .noData
        case .errorSaveData:
            return .errorSaveData
        case .errorDeleteData:
            return .errorDeleteData
        }
    }
        
}
