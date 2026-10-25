//
//  RootTabView.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 23/10/26.
//

import SwiftUI


//MARK: - Root Tab View
struct RootTabView: View {
    @State private var tabSelection: AppTab = .home
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeScreen()
                .tabItem { Label(AppTab.home.title, systemImage: tabSelection == .home ? AppIcon.TabIcon.home : AppIcon.TabIcon.homeSelected) }
                .tag(AppTab.home)
            RecordsScreen()
                .tabItem { Label(AppTab.records.title, systemImage: tabSelection == .records ? AppIcon.TabIcon.record : AppIcon.TabIcon.recordSelected) }
                .tag(AppTab.records)
        }
        .tint(.appColor)
    }
}

#Preview {
    RootTabView()
}

