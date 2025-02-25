//
//  AppCoordinator.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 28/01/25.
//
import SwiftUI
import SwiftData

class AppCoordinator: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var isAuthenticated: Bool

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
    }

    func push(page: AppPages) {
        DispatchQueue.main.async {
            self.path.append(page)
        }
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }

    func logout() {
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        popToRoot()
    }

    @MainActor @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .login:
            if let loginView = LoginViewFactory().build() {
                loginView
            }
        case .main:
            if let mainView = ScanningListViewFactory(modelContext: modelContext).build() {
                mainView
            }
        }
    }
}
