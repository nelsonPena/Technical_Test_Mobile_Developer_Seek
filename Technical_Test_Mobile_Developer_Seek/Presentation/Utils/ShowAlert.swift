//
//  ShowAlert.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation
import SwiftUI

enum AlertType {
    case info
    case error
    
    var titleText: String {
        switch self {
        case .info: return "Information"
        case .error: return "Error"
        }
    }
    
    var titleColor: Color {
        switch self {
        case .info: return .blue
        case .error: return .red
        }
    }
    
    var buttonRole: ButtonRole? {
        switch self {
        case .info: return .cancel
        case .error: return .destructive
        }
    }
}

extension View {
    func showAlert(isPresented: Binding<Bool>, message: String, type: AlertType = .info) -> some View {
        self.alert(type.titleText, isPresented: isPresented) {
            Button("OK", role: type.buttonRole) { }
        } message: {
            Text(message)
                .foregroundColor(type.titleColor) // ✅ Cambia color del mensaje
        }
    }
}
