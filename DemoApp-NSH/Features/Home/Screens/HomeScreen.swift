//
//  HomeScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

//MARK: - Home
struct HomeScreen: View {
    @State private var viewModel = HomeViewModel.init()
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case let .loaded(value):
                ScrollView {
                    Text(value.title)
                        .foregroundColor(.primaryTextColor)
                        .font(.header.bold())
                        .containerRelativeFrame(.horizontal)
                }
                .navigationBar(title: AppTab.home.title, isDetails: false)
            default: EmptyView()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
