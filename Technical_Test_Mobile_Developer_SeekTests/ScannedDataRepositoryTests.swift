//
//  ScannedDataRepositoryTests.swift
//  Technical_Test_Mobile_Developer_SeekTests
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import XCTest
import SwiftData
@testable import Technical_Test_Mobile_Developer_Seek

final class ScannedDataRepositoryTests: XCTestCase {
    
    var repository: ScannedDataRepositoryImpl!
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!

    override func setUp() {
        super.setUp()
        
        do {
            modelContainer = try ModelContainer(for: Scan.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            modelContext = ModelContext(modelContainer)
            repository = ScannedDataRepositoryImpl(context: modelContext)
        } catch {
            XCTFail("Failed to create in-memory ModelContainer: \(error)")
        }
    }

    override func tearDown() {
        repository = nil
        modelContext = nil
        modelContainer = nil
        super.tearDown()
    }
    
    func testFetchAll_ShouldReturnEmptyArray_WhenNoDataExists() {
        XCTAssertTrue(repository.scans?.isEmpty ?? false, "Expected empty array but found data")
    }
    
    func testSave_ShouldInsertScan_AndPublishChanges() {
        let scan = Scan(id: UUID(), scan: "Test Scan", timestamp: Date())

        XCTAssertNoThrow(try repository.save(model: scan))
        
        let savedScans = repository.scans ?? []
        XCTAssertEqual(savedScans.count, 1, "Scan should have been inserted")
        XCTAssertEqual(savedScans.first?.scan, "Test Scan", "Inserted scan data does not match")
    }
    
    func testDelete_ShouldRemoveScan_WhenScanExists() {
        let scan = Scan(id: UUID(), scan: "Test Scan", timestamp: Date())
        try? repository.save(model: scan)

        let domainScan = ScanDomainModel(id: scan.id, scan: scan.scan, timestamp: scan.timestamp)
        
        XCTAssertNoThrow(try repository.delete(scan: domainScan))

        let remainingScans = repository.scans ?? []
        XCTAssertTrue(remainingScans.isEmpty, "Scan should have been removed")
    }
    
    func testDelete_ShouldThrowError_WhenScanDoesNotExist() {
        let nonExistingScan = ScanDomainModel(id: UUID(), scan: "Non-Existent", timestamp: Date())

        XCTAssertThrowsError(try repository.delete(scan: nonExistingScan)) { error in
            XCTAssertEqual(error as? DomainError, DomainError.errorDeleteData, "Expected errorDeleteData")
        }
    }
}
