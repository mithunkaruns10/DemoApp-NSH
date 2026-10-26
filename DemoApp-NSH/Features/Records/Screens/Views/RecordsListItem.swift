//
//  RecordsListItem.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

//MARK:  Record Screen - card
struct RecordsListItem: View {
    let onTap: ()-> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(AppIcon.lab)
                .resizable()
                .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 2) {
                Text("Lab and Diagnostic")
                    .foregroundColor(.primaryTextColor)
                    .font(.header)
                Text("Result for blood, urine, and general lab")
                    .font(.subHeader)
                    .foregroundColor(.appBlackColor)
            }
            Spacer(minLength: 0)
        }
        .contentShape(Rectangle())
        .onTapGesture { onTap() }
        .padding(15)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 4)
    }
}

#Preview {
    RecordsListItem(onTap: {})
}
