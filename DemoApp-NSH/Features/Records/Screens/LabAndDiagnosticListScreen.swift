//
//  RecordsListScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct LabAndDiagnosticListScreen: View {
    @Binding var path: [AppRoute]
    var body: some View {
        ScrollView {
            ForEach(0..<5) {_ in
                LabAndDiagnosticItem {
                    path.append(.recordsDetails)
                }
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Lab and Diagnostics")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LabAndDiagnosticListScreen(path: .constant([.recordsDetails]))
}
