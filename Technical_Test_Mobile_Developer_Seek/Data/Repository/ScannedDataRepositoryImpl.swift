//
//  ScannedDataRepositoryImpl.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation
import SwiftData

final class ScannedDataRepositoryImpl{
    
    private let context: ModelContext
    @Published var scans: [Scan]?
    
    init(context: ModelContext) {
        self.context = context
        publish()
    }
    
    private func fetchAll() -> [Scan] {
        let descriptor = FetchDescriptor<Scan>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        return (try? context.fetch(descriptor)) ?? []
    }
    
    private func publish() {
        scans = fetchAll()
    }
    
    private func save() throws {
        do {
            try context.save()
        } catch {
            throw DataError.errorDeleteData
        }
        publish()
    }
}

extension ScannedDataRepositoryImpl: ScannedDataRepository  {
    
    var scanPublisher: Published<[Scan]?>.Publisher {
        $scans
    }
    
    func save(model: Scan) throws {
        context.insert(model)
        do {
            try save()
        } catch {
            throw error
        }
    }
    
    func delete(scan: ScanDomainModel) throws {
        
        let scanid = scan.id
        let fetchDescriptor = FetchDescriptor<Scan>(
            predicate: #Predicate { entity in
                entity.id == scanid
            }
        )
        do {
            let results = try context.fetch(fetchDescriptor)
            if let entityToDelete = results.first {
                context.delete(entityToDelete)
                try save()
            } else {
                throw DomainError.errorDeleteData
            }
        } catch {
            throw error
        }
    }
}
