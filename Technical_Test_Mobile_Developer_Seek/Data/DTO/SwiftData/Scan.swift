//
//  ScannedData.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import SwiftData
import Foundation

@Model
final class Scan {
    var id: UUID
    var scan: String
    var timestamp: Date

    init(id: UUID, scan: String, timestamp: Date) {
        self.id = id
        self.scan = scan
        self.timestamp = timestamp
    }
    
    func mapper() -> ScanDomainModel {
        .init(id: id, scan: scan, timestamp: timestamp)
    }
}


