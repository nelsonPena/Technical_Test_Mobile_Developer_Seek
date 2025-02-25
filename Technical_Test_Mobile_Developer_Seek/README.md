# Technical Test - Mobile Developer

## Overview
This project demonstrates how to switch between different persistence layers (`SwiftData` and `CoreData`) using Clean Architecture principles. The implementation ensures that the decision to use either `SwiftData` or `CoreData` is managed dynamically based on a configuration setting.

## Architecture Overview
The project follows **Clean Architecture**, separating concerns into different layers:

- **Presentation Layer**: Handles UI and user interaction (e.g., `ScanningListView`).
- **Domain Layer**: Contains business logic and use cases (e.g., `ScannedDataUseCase`).
- **Data Layer**: Responsible for data persistence and repository implementations (e.g., `ScannedDataRepositoryImpl`, `CoreDataProviderRepositoryImpl`).

## Dynamic Repository Selection
The application determines the persistence method based on the `Use Core Data` configuration in `Info.plist`:

```swift
private func createUseCase() -> ScannedDataUseCase? {
    guard let useCoreData = Bundle.main.infoDictionary?["Use Core Data"] as? String,
          useCoreData.elementsEqual("YES") else {
        return createRepository().map { ScannedSwiftDataUseCaseImpl(repository: $0) }
    }
    return createRepository().map { ScannedCoreDataRepositoryImpl(repository: $0) }
}
```

## Implementation Details
### **1. Factory for Dependency Injection**
The `ScanningListViewFactory` is responsible for creating dependencies dynamically:

```swift
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
        createUseCase().map { ScanningListViewModel(useCase: $0, errorMapper: PresentableErrorMapper()) }
    }
}
```

### **2. Repository Implementations**
Two repository implementations handle different data sources:

#### **SwiftData Repository**
```swift
final class ScannedDataRepositoryImpl: ScannedDataRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(model: Scan) throws {
        context.insert(model)
        try context.save()
    }
}
```

#### **CoreData Repository**
```swift
class CoreDataProviderRepositoryImpl: CoreDataProviderRepository {
    private var managedObjectContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }

    func add(domainModel: ScanDomainModel) throws {
        let scan = ScannedEntity(context: managedObjectContext)
        scan.id = domainModel.id
        scan.scan = domainModel.scan
        scan.timestamp = domainModel.timestamp
        try managedObjectContext.save()
    }
}
```

## How to Configure the Data Source
1. Open `Info.plist`.
2. Add or modify the key **`Use Core Data`**:
   - **YES** → Uses `CoreDataProviderRepositoryImpl`
   - **NO** → Uses `ScannedDataRepositoryImpl`

