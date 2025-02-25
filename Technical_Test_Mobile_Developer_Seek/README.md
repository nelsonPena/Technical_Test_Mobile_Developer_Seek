# Technical Test - Mobile Developer

## Overview
This project demonstrates how to switch between different persistence layers (`SwiftData` and `CoreData`) using Clean Architecture principles. The implementation ensures that the decision to use either `SwiftData` or `CoreData` is managed dynamically based on a configuration setting.

## Architecture Overview
The project follows **Clean Architecture**, ensuring low coupling and high scalability. It includes:

- **Factory Implementation**: `ScanningListViewFactory` centralizes the creation of all layers (Presentation, Domain, and Data), improving maintainability and flexibility.
- **Low Coupling**: Components interact through abstractions, making it easier to extend or modify the system.
- **Swift + AVFoundation**: Integrates with Apple's media frameworks for advanced functionalities.
- **Biometric Authentication**: Supports Face ID and Touch ID for enhanced security.

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

## Benefits of Clean Architecture in This Implementation
✅ **Scalability** - Adding a new persistence layer (e.g., Firebase, Realm) requires minimal changes.  
✅ **Separation of Concerns** - UI, business logic, and data persistence are decoupled.  
✅ **Testability** - Each component can be unit tested independently.  
✅ **Flexibility** - The system dynamically selects the best repository implementation.  
✅ **Security** - Biometric authentication enhances user protection.  

## Conclusion
This approach ensures a clean, scalable, and testable implementation for dynamically selecting a persistence layer based on configuration settings, while integrating **AVFoundation** for media handling and **biometric authentication** for secure access.

