//
//  ScanningListView.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct ScanningListView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: ScanningListViewModel
    @State private var isScannerPresented = false
    @State private var alertMessage: String = ""
    @State private var alertType: AlertType = .info
    @State private var showAlert = false
    
    init(viewModel: ScanningListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            headerView
            if viewModel.scannings.isEmpty {
                emptyStateView
            } else {
                scanListView
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isScannerPresented = true }) {
                    Label("Scan QR", systemImage: "qrcode.viewfinder")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    coordinator.logout()
                    coordinator.push(page: .login)
                }) {
                    Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                }
            } }
        
        .showAlert(
            isPresented: $showAlert,
            message: alertMessage,
            type: alertType
        )
        .onAppear {
            viewModel.onShowAlert = { message, alertType in
                alertMessage = message
                showAlert = true
                self.alertType = alertType
            }
        }
        .sheet(isPresented: $isScannerPresented) { scannerSheet }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("Scanned QR Codes")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)
                .padding(.top, 20)
            
            Divider()
        }
    }
    
    private var scanListView: some View {
        List {
            ForEach(viewModel.scannings, id: \.id) { scan in
                ScanItemView(scan: scan)
                    .padding(.vertical, 8)
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    // 🔹 Estado cuando la lista está vacía
    private var emptyStateView: some View {
        VStack {
            Image(systemName: "qrcode")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray.opacity(0.5))
                .padding(.bottom, 10)
            
            Text("No scans available")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
        }
        .padding(.top, 40)
    }
    
    private var scanButton: some View {
        Button(action: { isScannerPresented = true }) {
            Label("Scan QR", systemImage: "qrcode.viewfinder")
                .font(.system(size: 18))
        }
    }
    
    private var logoutButton: some View {
        Button(action: {
            coordinator.logout()
            coordinator.push(page: .login)
        }) {
            Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                .font(.system(size: 18))
                .foregroundColor(.red)
        }
    }
    
    private var scannerSheet: some View {
        let permissionManager = CameraPermissionManager()
        let requestPermissionUseCase = RequestCameraPermissionUseCase(permissionManager: permissionManager)
        let scannerViewModel = ScannerViewModel(requestPermissionUseCase: requestPermissionUseCase)
        
        return ScannerView(viewModel: scannerViewModel) { scannedData in
            isScannerPresented = false
            viewModel.addScan(scan: scannedData)
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let selectedScan = viewModel.scannings[index]
            viewModel.deleteScan(scan: selectedScan)
        }
    }
}

#Preview {
    let sharedModelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: Scan.self)
        } catch {
            fatalError("❌ Failed to create ModelContainer: \(error.localizedDescription)")
        }
    }()
    ScanningListViewFactory(modelContext: sharedModelContainer.mainContext).build()
        .modelContainer(for: Scan.self, inMemory: true)
}
