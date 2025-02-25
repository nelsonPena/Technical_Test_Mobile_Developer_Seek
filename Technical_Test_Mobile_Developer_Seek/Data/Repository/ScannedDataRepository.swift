//
//  ScannedDataRepository.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation

protocol ScannedDataRepository {
    func save(model: Scan) throws
    var scanPublisher: Published<[Scan]?>.Publisher { get }
    func delete(scan: ScanDomainModel) throws
}
