//
//  ScanningListViewModel.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import SwiftUI
import Combine

class ScanningListViewModel: ObservableObject {
    
    private var scannedDataUseCase: ScannedDataUseCase
    private var errorMapper: PresentableErrorMapper
    
    private var cancellables = Set<AnyCancellable>()
    @Published var scannings: [ScanPresentableModel] = []
    var onShowAlert: ((String, AlertType) -> Void)?
    
    init(useCase: ScannedDataUseCase,
         errorMapper: PresentableErrorMapper) {
        self.scannedDataUseCase = useCase
        self.errorMapper = errorMapper
        loadScans()
    }
    
    func loadScans() {
        do {
            try scannedDataUseCase.getScannedData()
                .sink { [weak self] scannedData in
                    guard let self = self else { return }
                    self.scannings = scannedData?.map { $0.mapper() } ?? []
                }
                .store(in: &cancellables)
        }catch {
            let error = errorMapper.mapError(error: error as? DomainError ?? .generic)
            onShowAlert?(error, .error)
        }
    }
    
    func addScan(scan: String) {
        do{
            let scannedData = ScanDomainModel(id: UUID(), scan: scan, timestamp: Date())
            try scannedDataUseCase.addScannedData(model: scannedData)
            loadScans()
        } catch {
            let error = errorMapper.mapError(error: error as? DomainError ?? .generic)
            onShowAlert?(error, .error)
        }
    }
    
    func deleteScan(scan: ScanPresentableModel) {
        do{
            try scannedDataUseCase.removeScannedData(scan: scan.mapper())
            loadScans()
        }catch {
            let error = errorMapper.mapError(error: error as? DomainError ?? .generic)
            onShowAlert?(error, .error)
        }
    }
}
