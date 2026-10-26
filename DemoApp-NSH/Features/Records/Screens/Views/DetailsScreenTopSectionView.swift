//
//  DetailsScreenTopSectionView.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

//MARK: Details Screen - top section
struct DetailsScreenTopSectionView: View {
    let labReport: LabReport
    var body: some View {
        HStack(spacing:0) {
            VStack(alignment: .leading, spacing: 15) {
                DetailsField(title: "Report Name", value: labReport.title)
                DetailsField(title: "Test Performer", value: labReport.performer ?? "")
                DetailsField(title: "Result Date and Time", value: labReport.date?.toMMMMddyyyyHHmmssFormat ?? "")
            }
            Spacer(minLength: 15)
        }
        .padding(12)
    }
}


private struct DetailsField: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.primaryTextColor)
                .font(.header)
            Text(value)
                .foregroundColor(.primaryTextColor)
                .font(.subHeader)
        }
    }
}

#Preview {
    DetailsScreenTopSectionView(
        labReport: .init(
            id: "",
            title: "Test",
            date: Date(),
            performer: "ABC Lab",
            obsercations: [
                .init(
                    id: "",
                    name: "Ob1",
                    value: "test",
                    normalRange: "10-15"
                )
            ]
        )
    )
}
