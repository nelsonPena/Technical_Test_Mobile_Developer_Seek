//
//  FlutterEngineProvider.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 13/03/25.
//

import Flutter
import SwiftUI

protocol FlutterEngineProvider {
    associatedtype FlutterView: View
    var engine: FlutterEngine { get }
    func createFlutterView() -> FlutterView
    func setupFlutterMethodChannel(viewController: FlutterViewController)
}
