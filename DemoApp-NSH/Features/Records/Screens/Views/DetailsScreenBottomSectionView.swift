//
//  DetailsScreenBottomSectionView.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

//MARK: Details Screen - bottom section
struct DetailsScreenBottomSectionView: View {
    let observations: [LabObservation]
    var body: some View {
        if observations.isEmpty {
            Text("No results found.")
                .foregroundColor(.primaryTextColor)
                .font(.header)
        } else {
            ForEach(observations) { observation in
                DetailsScreenBottomSectionItem(observation: observation)
            }
        }
    }
}


struct DetailsScreenBottomSectionItem: View {
    let observation: LabObservation
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                Text(observation.name)
                    .foregroundColor(.primaryTextColor)
                    .font(.header)
                DetailsLabeledValue(
                    label: "Result:",
                    value: observation.value ?? "--"
                )
                if let referenceRange = observation.normalRange {
                    DetailsLabeledValue(
                        label: "Normal Range:",
                        value: referenceRange
                    )
                }
            }
            Spacer(minLength: 15)
        }
        .padding(12)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
    }
}

private struct DetailsLabeledValue: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 5) {
            Text(label)
                .foregroundColor(.primaryTextColor)
                .font(.subHeader.bold())
            Text(value)
                .foregroundColor(.primaryTextColor)
                .font(.subHeader)
        }
    }
}

#Preview {
    DetailsScreenBottomSectionView(
        observations: [
            .init(
                id: "",
                name: "Ob1",
                value: "test",
                normalRange: "10-15"
            )
        ]
    )
}
