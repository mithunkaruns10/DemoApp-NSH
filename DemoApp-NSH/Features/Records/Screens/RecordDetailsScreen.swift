//
//  RecordDetailsScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct RecordDetailsScreen: View {
    var body: some View {
            ScrollView {
                VStack(spacing: 15) {
                    DetailsScreenTopSectionView()
                    Divider()
                    DetailsScreenBottomSectionView()
                }
                .padding(.horizontal, 15)
            }
            .navigationTitle("Complete blood count")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecordDetailsScreen()
}
