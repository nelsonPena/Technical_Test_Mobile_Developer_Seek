//
//  ScannedSwiftDataUseCaseImpl.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation
import Combine

final class ScannedSwiftDataUseCaseImpl: ScannedDataUseCase {
    
    private let repository: ScannedDataRepository
    
    init(repository: ScannedDataRepository) {
        self.repository = repository
    }
    
    func addScannedData(model: ScanDomainModel) throws {
        try repository.save(model: model.mapper())
    }
    
    func getScannedData() throws -> AnyPublisher<[ScanDomainModel]?, Never> {
        repository.scanPublisher
            .tryMap { scannedEntities -> [ScanDomainModel] in
                guard let scannedEntities = scannedEntities else {
                    throw DomainError.noData
                }
                return scannedEntities.map { ScanDomainModel(id: $0.id, scan: $0.scan, timestamp: $0.timestamp) }
            }
            .catch { error -> Just<[ScanDomainModel]?> in
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    func removeScannedData(scan: ScanDomainModel) throws {
        try repository.delete(scan: scan)
    }
}
