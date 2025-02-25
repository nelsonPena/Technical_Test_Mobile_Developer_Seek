//
//  ScannedCoreDataUseCaseImpl.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation
import Combine
import CoreData

final class ScannedCoreDataRepositoryImpl: ScannedDataUseCase {
    
    private let repository: CoreDataProviderRepository
    
    init(repository: CoreDataProviderRepository) {
        self.repository = repository
    }
    
    func addScannedData(model: ScanDomainModel) throws {
        do {
            try repository.add(domainModel: model)
        } catch {
            throw DomainError.errorSaveData
        }
    }
    
    func getScannedData() throws -> AnyPublisher<[ScanDomainModel]?, Never>  {
        repository.savedScanPublisher
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
        do {
            try repository.delete(scan)
        } catch {
            throw DomainError.errorDeleteData
        }
    }
}
