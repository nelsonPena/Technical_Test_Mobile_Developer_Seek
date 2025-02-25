//
//  ScanItemView.swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 24/02/25.
//

import SwiftUI

struct ScanItemView: View {
    let scan: ScanPresentableModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(scan.scan)
                .font(.headline)
                .foregroundColor(.primary)

            Text(scan.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}
