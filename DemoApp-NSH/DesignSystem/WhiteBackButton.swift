//
//  WhiteBackButton.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import SwiftUI

//MARK: - Custom back button
struct WhiteBackButton: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: AppIcon.back)
                                .font(.body.weight(.semibold))
                                .foregroundStyle(Color.backButtonColor)
                        }
                    }
                    .sharedBackgroundVisibility(.hidden)
                }
        } else {
            content
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: AppIcon.back)
                                .font(.body.weight(.semibold))
                                .foregroundStyle(Color.backButtonColor)
                        }
                    }
                }
            
        }
    }
}

extension View {
    func appBackButton() -> some View {
        modifier(WhiteBackButton())
    }
}
