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
    
    func createFlutterView() -> FlutterViewControllerWrapper? {
        let flutterViewController = FlutterViewController(engine: engineProvider.engine, nibName: nil, bundle: nil)
               setupFlutterMethodChannel(viewController: flutterViewController)
        return FlutterViewControllerWrapper(engine: engineProvider.engine)
    }
    
    private func setupFlutterMethodChannel(viewController: FlutterViewController) {
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
