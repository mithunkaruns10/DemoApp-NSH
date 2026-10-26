//
//  LabAndDiagnosticItem.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

//MARK: Lab and Diagnostic Screen - card
struct LabAndDiagnosticItem: View {
    let labReport: LabReport
    let onTap: ()-> Void
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(labReport.title)
                        .foregroundColor(.primaryTextColor)
                        .font(.header.bold())
                    Text("Diagnostic Report")
                        .foregroundColor(.appGreyColor)
                        .font(.subHeader.bold())
                }
                Text(labReport.date?.toMMMMddyyyyFormat ?? "")
                    .foregroundColor(.primaryTextColor)
                    .font(.subHeader.bold())
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
    LabAndDiagnosticItem(
        labReport: .init(
            id: "",
            title: "Test",
            date: Date(),
            performer: "ABC Lab",
            observations: [.init(
                id: "",
                name: "Ob1",
                value: "test",
                normalRange: "10-15"
            )]),
        onTap: {}
    )
}
