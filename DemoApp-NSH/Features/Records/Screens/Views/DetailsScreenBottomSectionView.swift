//
//  DetailsScreenBottomSectionView.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct DetailsScreenBottomSectionView: View {
    var body: some View {
        ForEach(0..<3) {_ in
            DetailsScreenBottomSectionItem()
        }
    }
}


struct DetailsScreenBottomSectionItem: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                Text("Title")
                    .font(.headline)
                HStack(spacing: 5) {
                    Text("Subtitle:")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                    Text("Subtitl")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                HStack(spacing: 5) {
                    Text("Subtitle:")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                    Text("Subtitl")
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
    DetailsScreenBottomSectionView()
}
