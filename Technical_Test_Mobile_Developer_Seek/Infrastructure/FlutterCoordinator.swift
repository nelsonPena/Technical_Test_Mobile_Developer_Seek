//
//  FlutterCoordinator.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 13/03/25.
//

import Flutter
import SwiftUI

import Flutter
import SwiftUI

class FlutterCoordinator {
    private let engineProvider: any FlutterEngineProvider
    
    init(engineProvider: any FlutterEngineProvider) {
        self.engineProvider = engineProvider
    }
    
    func createFlutterView() -> any View {
        engineProvider.createFlutterView()
    }
}
