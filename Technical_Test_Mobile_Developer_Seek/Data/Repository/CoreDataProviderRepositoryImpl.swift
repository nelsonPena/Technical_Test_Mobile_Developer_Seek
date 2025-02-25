//
//  DataProviderRepositoryImpl vcdjts.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Geovanny Pena Agudelo on 15/10/23.
//

import Foundation
import Combine
import CoreData

class CoreDataProviderRepositoryImpl {
    
    private var managedObjectContext: NSManagedObjectContext

    @Published var scans: [ScannedEntity]?
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        publish()
    }
    
    private func allScans() -> [ScannedEntity]? {
        do {
            let fetchRequest: NSFetchRequest<ScannedEntity> = ScannedEntity.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]

            return try self.managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Error fetching scans: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Guarda los cambios realizados en el contexto de CoreData.
    private func save() throws {
        do {
            try self.managedObjectContext.save()
        } catch {
            throw DataError.errorSaveData
        }
        publish()
    }
    
    /// Publica la lista de los personajes .
    private func publish() {
        scans = allScans()
    }
}

extension CoreDataProviderRepositoryImpl: CoreDataProviderRepository {
    
    var savedScanPublisher: Published<[ScannedEntity]?>.Publisher {
        $scans
    }
    
    func add(domainModel: ScanDomainModel) throws {
        let scan = ScannedEntity(context: managedObjectContext)
        scan.id = domainModel.id
        scan.scan = domainModel.scan
        scan.timestamp = domainModel.timestamp
        do {
            try save()
        } catch {
            throw error
        }
    }
    
    func delete(_ scan: ScanDomainModel) throws {
        let fetchRequest: NSFetchRequest<ScannedEntity> = ScannedEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "scan == %@ AND timestamp == %@", scan.scan, scan.timestamp as CVarArg)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            if let entityToDelete = results.first {
                managedObjectContext.delete(entityToDelete)
               try save()
            }
        } catch {
            throw DataError.errorDeleteData
        }
    }
}
