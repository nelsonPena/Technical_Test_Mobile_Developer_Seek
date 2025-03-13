//
//  Technical_Test_Mobile_Developer_SeekApp.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import SwiftUI
import SwiftData
import Flutter

@main
struct Technical_Test_Mobile_Developer_SeekApp: App {
    
    @StateObject private var appCoordinator: AppCoordinator
    
    init() {
        let provider = DefaultFlutterEngineProvider()
        let flutterCoordinator = FlutterCoordinator(engineProvider: provider)
        let sharedModelContainer = try! ModelContainer(for: Scan.self)
        _appCoordinator = StateObject(wrappedValue: AppCoordinator(modelContext: sharedModelContainer.mainContext,
                                                                   flutterCoordinator: flutterCoordinator))
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                contentView
                    .navigationDestination(for: AppPages.self) { page in
                        appCoordinator.build(page: page)
                    }
            }
        }
        .environmentObject(appCoordinator)
        .modelContainer(for: Scan.self)
    }
    
    var contentView: some View {
        guard appCoordinator.isAuthenticated else {
            return appCoordinator.build(page: .login)
        }
        return appCoordinator.build(page: .main)
    }
}
