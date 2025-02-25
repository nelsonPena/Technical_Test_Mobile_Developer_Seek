//
//  PasswordModalView.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation

import SwiftUI

struct PasswordModalView: View {
    @State private var newPassword: String = ""
    @Environment(\.presentationMode) var presentationMode
    var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Your Password")
                .font(.system(size: 22, weight: .bold))
                .padding(.top, 30)

            SecureField("Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)
                .padding(.top, 10)

            Button(action: {
                viewModel.savePassword(newPassword)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Sign In")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 30)

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.red)
            }
            .padding(.top, 10)

            Spacer()
        }
        .frame(maxWidth: 400)
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}
