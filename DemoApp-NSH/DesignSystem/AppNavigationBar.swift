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
            navigationTitle(
                title: title,
                isDetails: isDetails,
                content: content
            )
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

///Helper to handle version below & above iOS 26.0
@ViewBuilder
private func navigationTitle(title: String, isDetails: Bool, content: some View) ->  some View {
    if #available(iOS 26.0, *) {
        content
            .navigationTitle(title)
            .toolbarTitleDisplayMode(isDetails ? .inline : .inlineLarge)
    } else {
        content
            .navigationTitle(title)
            .toolbarTitleDisplayMode(isDetails ? .inline : .inlineLarge)
            .toolbarBackground(Color.appColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                if isDetails {
                    ToolbarItem(placement:.principal) {
                        Text(title)
                            .font(isDetails ? .header.weight(.semibold) : .subHeader.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }
                }
            }
    }
}

extension View {
    func navigationBar(title: String, isDetails: Bool) -> some View {
        modifier(AppNavigationBar(title: title, isDetails: isDetails))
    }
}
