//
//  DataProviderRepository.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation

protocol CoreDataProviderRepository: AnyObject {
    var savedScanPublisher: Published<[ScannedEntity]?>.Publisher { get }
    func add(domainModel: ScanDomainModel) throws
    func delete(_ scan: ScanDomainModel) throws
}
