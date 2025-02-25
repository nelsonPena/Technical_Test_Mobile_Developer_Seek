//
//  CameraPermissionManager.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import AVFoundation
import UIKit

class CameraPermissionManager {
    func checkPermission(completion: @escaping (AVAuthorizationStatus) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        guard case .notDetermined = status else {
            completion(status)
            return
        }
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(.authorized)
            }
        }
    }
    
}
