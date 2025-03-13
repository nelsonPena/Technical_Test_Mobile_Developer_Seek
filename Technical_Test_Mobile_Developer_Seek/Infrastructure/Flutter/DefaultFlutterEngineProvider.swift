//
//  DefaultFlutterEngineProvider.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 13/03/25.
//

import Flutter

class DefaultFlutterEngineProvider: FlutterEngineProvider {
    
    let engine: FlutterEngine
    
    typealias FlutterView = FlutterViewControllerWrapper
    
    init() {
        self.engine = FlutterEngine(name: "primary_flutter_engine")
        self.engine.run()
    }
    
    func createFlutterView() -> FlutterViewControllerWrapper {
        let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        setupFlutterMethodChannel(viewController: flutterViewController)
        return FlutterViewControllerWrapper(engine: engine)
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
