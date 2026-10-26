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
            ///Home Screen
            HomeScreen()
                .tabItem {
                        Image(tabSelection == .home ? AppIcon.TabIcon.homeSelected :  AppIcon.TabIcon.home)
                        .renderingMode(tabSelection == .home ? .template : .original)
                        .tint(tabSelection == .home ? Color.appColor : Color.appBlackColor)
                        Text(AppTab.home.title)
                }
                .tag(AppTab.home)
            
            ///Records Screen
            RecordsScreen()
                .tabItem {
                    Image(tabSelection == .records ? AppIcon.TabIcon.recordSelected :  AppIcon.TabIcon.record)
                        .renderingMode(tabSelection == .records ? .template : .original)
                        .tint(tabSelection == .records ? Color.appColor : Color.appBlackColor)
                    Text(AppTab.records.title)
                }
                .tag(AppTab.records)
        }
        .tint(.appColor)
    }
}

#Preview {
    RootTabView()
}

