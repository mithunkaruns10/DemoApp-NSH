//
//  DetailsScreenTopSectionView.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct DetailsScreenTopSectionView: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.headline)
                    Text("Subtitle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.headline)
                    Text("Subtitle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.headline)
                    Text("Subtitle")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer(minLength: 15)
        }
        .padding(12)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
        .frame(width: .infinity)
    }
}

#Preview {
    DetailsScreenTopSectionView()
}
