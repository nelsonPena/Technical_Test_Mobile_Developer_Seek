//
//  ScannerView.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import SwiftUI
import AVFoundation

struct ScannerView: View {
    @ObservedObject var viewModel: ScannerViewModel
    var onScan: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            if viewModel.isCameraAuthorized ?? false {
                CameraPreviewView(onScan: onScan)
                    .edgesIgnoringSafeArea(.all)
                
                scanOverlay
            } else {
                permissionRequestView
            }

            closeButton
        }
        .onAppear {
            viewModel.requestCameraPermission()
        }
    }

    // 🔹 Marco de escaneo con animación
    private var scanOverlay: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.green, lineWidth: 4)
            .frame(width: 250, height: 250)
            .background(Color.black.opacity(0.3))
            .cornerRadius(12)
    }

    // 🔹 Vista cuando la cámara no tiene permisos
    private var permissionRequestView: some View {
        VStack(spacing: 16) {
            Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)

            Text("Camera Access Needed")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Please allow camera access in Settings to scan QR codes.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Button(action: {
                viewModel.requestCameraPermission()
            }) {
                Text("Grant Permission")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
        }
    }

    // 🔹 Botón para cerrar el escáner
    private var closeButton: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                }
                .padding()
                Spacer()
            }
            Spacer()
        }
    }
}
