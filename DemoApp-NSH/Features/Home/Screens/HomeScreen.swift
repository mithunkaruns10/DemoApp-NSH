//
//  HomeScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Demo App")
                    .font(.headline)
            }
            .navigationTitle(AppTab.home.title)
        }
    }
}

#Preview {
    HomeScreen()
}
