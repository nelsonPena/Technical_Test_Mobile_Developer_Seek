//
//  ScannedDataUseCase.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Combine

protocol ScannedDataUseCase: AnyObject {
    func addScannedData(model: ScanDomainModel) throws
    func getScannedData() throws -> AnyPublisher<[ScanDomainModel]?, Never> 
    func removeScannedData(scan: ScanDomainModel) throws
}
