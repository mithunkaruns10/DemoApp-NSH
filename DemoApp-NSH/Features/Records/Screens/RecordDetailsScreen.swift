//
//  RecordDetailsScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

//MARK: Record Details Screen
struct RecordDetailsScreen: View {
    let labReport: LabReport
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                DetailsScreenTopSectionView(labReport: labReport)
                Divider()
                DetailsScreenBottomSectionView(observations: labReport.obsercations)
            }
            .padding(.horizontal, 15)
        }
        .navigationBar(title: "Complete blood count", isDetails: true)
        .navigationBarBackButtonHidden(true)
        .appBackButton()
    }
}

#Preview {
    RecordDetailsScreen(
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
