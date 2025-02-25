//
//  ScannerViewModel.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import SwiftUI
import AVFoundation

class ScannerViewModel: ObservableObject {
  
    private let requestPermissionUseCase: RequestCameraPermissionUseCase
    @Published var isCameraAuthorized = false
    private var status: AVAuthorizationStatus = .notDetermined

    init(requestPermissionUseCase: RequestCameraPermissionUseCase) {
        self.requestPermissionUseCase = requestPermissionUseCase
    }

    func requestCameraPermission() {
        guard status == .notDetermined else {
            openAppSettings()
            return
        }
        requestPermissionUseCase.execute { [weak self] status in
            guard let self = self else { return }
            self.isCameraAuthorized = status == .authorized
            self.status = status
        }
    }
    
    func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}
