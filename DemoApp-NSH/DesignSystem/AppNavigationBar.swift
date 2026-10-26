//
//  AppNavigationBar.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import SwiftUI

//MARK: Custom Navigation bar
struct AppNavigationBar: ViewModifier {
    let title: String
    let isDetails: Bool
    
    private static let  cornerRadius: CGFloat = 15
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .toolbarTitleDisplayMode(isDetails ? .inline : .inlineLarge)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: Self.cornerRadius)
            }
            .overlay(alignment: .top) {
                GeometryReader { proxy in
                    UnevenRoundedRectangle(bottomTrailingRadius: Self.cornerRadius)
                        .fill(Color.appColor)
                        .frame(height: proxy.safeAreaInsets.top)
                        .ignoresSafeArea(edges: .top)
                }
                .allowsHitTesting(false)
            }
    }
}


extension View {
    func navigationBar(title: String, isDetails: Bool) -> some View {
        modifier(AppNavigationBar(title: title, isDetails: isDetails))
    }
}
