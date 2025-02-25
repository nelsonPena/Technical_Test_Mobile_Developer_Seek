//
//  ScanDomainModel.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation

struct ScanDomainModel {
    var id: UUID
    var scan: String
    var timestamp: Date

    init(id: UUID, scan: String, timestamp: Date) {
        self.id = id
        self.scan = scan
        self.timestamp = timestamp
    }
    
    func mapper() -> Scan {
        .init(id: id, scan: scan, timestamp: timestamp)
    }
    
    func mapper() -> ScanPresentableModel {
        .init(id: id, scan: scan, timestamp: timestamp)
    }
}
