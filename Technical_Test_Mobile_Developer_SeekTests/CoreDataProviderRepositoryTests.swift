//
//  CoreDataProviderRepositoryTests.swift
//  Technical_Test_Mobile_Developer_SeekTests
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import XCTest
import CoreData
@testable import Technical_Test_Mobile_Developer_Seek

final class CoreDataProviderRepositoryTests: XCTestCase {
    
    var repository: CoreDataProviderRepositoryImpl!
    var persistentContainer: NSPersistentContainer!
    var managedObjectContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        
        persistentContainer = NSPersistentContainer(name: "Model")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory CoreData store: \(error)")
            }
        }
        
        managedObjectContext = persistentContainer.viewContext
        repository = CoreDataProviderRepositoryImpl(context: managedObjectContext)
    }

    override func tearDown() {
        repository = nil
        managedObjectContext = nil
        persistentContainer = nil
        super.tearDown()
    }
    
    func testFetchAll_ShouldReturnEmptyArray_WhenNoDataExists() {
        XCTAssertTrue(repository.scans?.isEmpty ?? false, "Expected empty array but found data")
    }
    
    func testSave_ShouldInsertScan_AndPublishChanges() {
        let scan = ScanDomainModel(id: UUID(), scan: "Test Scan", timestamp: Date())

        XCTAssertNoThrow(try repository.add(domainModel: scan))
        
        let fetchRequest: NSFetchRequest<ScannedEntity> = ScannedEntity.fetchRequest()
        let savedScans = try? managedObjectContext.fetch(fetchRequest)
        
        XCTAssertEqual(savedScans?.count, 1, "Scan should have been inserted")
        XCTAssertEqual(savedScans?.first?.scan, "Test Scan", "Inserted scan data does not match")
    }
    
    func testDelete_ShouldRemoveScan_WhenScanExists() {
        let scan = ScanDomainModel(id: UUID(), scan: "Test Scan", timestamp: Date())
        try? repository.add(domainModel: scan)

        XCTAssertNoThrow(try repository.delete(scan))

        let fetchRequest: NSFetchRequest<ScannedEntity> = ScannedEntity.fetchRequest()
        let remainingScans = try? managedObjectContext.fetch(fetchRequest)
        XCTAssertTrue(remainingScans?.isEmpty ?? false, "Scan should have been removed")
    }
    
    func testDelete_ShouldThrowError_WhenScanDoesNotExist() {
        let nonExistingScan = ScanDomainModel(id: UUID(), scan: "Non-Existent", timestamp: Date())

        XCTAssertThrowsError(try repository.delete(nonExistingScan)) { error in
            XCTAssertEqual(error as? DataError, DataError.errorDeleteData, "Expected errorDeleteData")
        }
    }
}

