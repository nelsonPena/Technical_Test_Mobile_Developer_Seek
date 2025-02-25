//
//  LoginView.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @State var password: String = ""
    @State var showAlert = false
    @State private var showPasswordModal = false
    @State private var alertMessage: String = ""
    @State private var alertType: AlertType = .info
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "lock.shield.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
                .padding(.bottom, 10)
                .transition(.scale)
            
            Text("Sign in to your Account")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.primary)
            
            Text("Use Face ID, Touch ID, or enter your password.")
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            if viewModel.showPasswordPrompt {
                passwordLoginSection
            }else{
                biometricLoginButton
            }
            
            setPasswordButton
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showPasswordModal) {
            PasswordModalView(viewModel: viewModel)
        }
        .onAppear {
            viewModel.onShowAlert = { message, alertType in
                alertMessage = message
                showAlert = true
                self.alertType = alertType
            }
            viewModel.showPasswordModal = false
            viewModel.isAuthenticated = false
        }
        .onChange(of: viewModel.isAuthenticated) { oldValue, newValue in
            if newValue {
                appCoordinator.push(page: .main)
            }
        }
        .showAlert(
            isPresented: $showAlert,
            message: alertMessage,
            type: alertType
        )
        .navigationBarBackButtonHidden(true)
    }
    
    private var biometricLoginButton: some View {
        Button(action: {
            viewModel.authenticate()
        }) {
            HStack {
                Image(systemName: "faceid")
                Text("Use Face ID / Touch ID")
            }
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .padding(.horizontal, 40)
    }
    
    private var passwordLoginSection: some View {
        VStack {
            SecureField("Enter password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                viewModel.authenticateWithPassword(password: password)
            }) {
                Text("Login with Password")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
        }
        .transition(.opacity)
    }
    
    private var setPasswordButton: some View {
        Button(action: {
            showPasswordModal = true
        }) {
            Text("Set Password")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.blue)
        }
        .padding(.top, 10)
    }
}
