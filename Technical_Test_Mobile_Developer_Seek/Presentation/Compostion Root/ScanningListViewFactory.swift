//
//  ScanListFactory.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation
import SwiftData

class ScanningListViewFactory {
    
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func build() -> ScanningListView? {
        guard let viewModel = createViewModel() else { return nil }
        return ScanningListView(viewModel: viewModel)
    }

    private func createViewModel() -> ScanningListViewModel? {
        createUseCase().map { ScanningListViewModel(useCase: $0,
                                                    errorMapper: PresentableErrorMapper()) }
    }

    private func createUseCase() -> ScannedDataUseCase? {
        guard let useCoreData = Bundle.main.infoDictionary?["Use Core Data"] as? String,
              useCoreData.elementsEqual("YES") else {
            
            return createRepository().map { ScannedSwiftDataUseCaseImpl(repository: $0) }
        }
        return createRepository().map { ScannedCoreDataRepositoryImpl(repository: $0) }
    }

    private func createRepository() -> ScannedDataRepository? {
         ScannedDataRepositoryImpl(context: modelContext)
    }
    
    private func createRepository() -> CoreDataProviderRepository? {
         CoreDataProviderRepositoryImpl(context: PersistenceController.shared.container.viewContext)
    }
}
