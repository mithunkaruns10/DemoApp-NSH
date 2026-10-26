//
//  HomeScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel.init()
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case let .loaded(value):
                ScrollView {
                    Text(value.title)
                        .font(.headline)
                }
                .navigationTitle(AppTab.home.title)
            default: EmptyView()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
