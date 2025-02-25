//
//  ScanPresentableModel.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation

struct ScanPresentableModel {
    let id: UUID
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
    
    static func == (lhs: ScanPresentableModel, rhs: ScanPresentableModel) -> Bool {
        return lhs.scan == rhs.scan && lhs.timestamp == rhs.timestamp
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(scan)
        hasher.combine(timestamp)
    }
}
