//
//  FlutterViewControllerWrapper.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 13/03/25.
//

import Flutter
import SwiftUI

struct FlutterViewControllerWrapper: UIViewControllerRepresentable {
    let engine: FlutterEngine

    func makeUIViewController(context: Context) -> FlutterViewController {
        return FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    }

    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {}
}
