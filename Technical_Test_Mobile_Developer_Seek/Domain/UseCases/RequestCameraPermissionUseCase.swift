//
//  RequestCameraPermissionUseCase.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import Foundation
import AVFoundation

class RequestCameraPermissionUseCase {
    private let permissionManager: CameraPermissionManager

    init(permissionManager: CameraPermissionManager) {
        self.permissionManager = permissionManager
    }

    func execute(completion: @escaping (AVAuthorizationStatus) -> Void) {
        permissionManager.checkPermission(completion: completion)
    }
}
