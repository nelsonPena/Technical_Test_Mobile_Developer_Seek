//
//  FlutterCoordinator.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 13/03/25.
//

import Flutter
import SwiftUI

class FlutterCoordinator {
    private var flutterEngine: FlutterEngine
    
    init() {
        self.flutterEngine = FlutterEngine(name: FlutterConstants.primaryEngineName)
        self.flutterEngine.run()
    }
    
    func createFlutterView() -> some View {
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        setupFlutterMethodChannel(viewController: flutterViewController)
        return FlutterViewControllerWrapper(engine: flutterEngine)
    }
    
    func setupFlutterMethodChannel(viewController: FlutterViewController) {
        let methodChannel = FlutterMethodChannel(name: FlutterConstants.methodChannelName,
                                                 binaryMessenger: viewController.binaryMessenger)
        
        methodChannel.setMethodCallHandler { (call, result) in
            if call.method == "getData" {
                result("Hello from iOS!")
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
