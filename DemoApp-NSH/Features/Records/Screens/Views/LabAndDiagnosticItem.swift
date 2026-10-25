//
//  LabAndDiagnosticItem.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct LabAndDiagnosticItem: View {
    let onTap: ()-> Void
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Title")
                        .font(.headline)
                    Text("Subtitle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Text("Mar 04, 2011")
                    .font(.footnote)
            }
            Spacer(minLength: 15)
        }
        .contentShape(Rectangle())
        .onTapGesture { onTap() }
        .padding(12)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    LabAndDiagnosticItem(onTap: {})
}
