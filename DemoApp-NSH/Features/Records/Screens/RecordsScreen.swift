//
//  RecordsScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

//MARK: Records Screen
struct RecordsScreen: View {
    @State private var path: [AppRoute] = []
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                    RecordsListItem {
                        path.append(.labAndDiagnostic)
                    }
                    .padding(.horizontal, 15)
            }
            .navigationBar(title: AppTab.records.title, isDetails: false)
            .navigationDestination(for: AppRoute.self) { route in
                Group {
                    switch route {
                    case .labAndDiagnostic:
                        LabAndDiagnosticListScreen(path: $path)
                    case let .recordsDetails(report):
                        RecordDetailsScreen(labReport: report)
                    }
                }
                .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}

#Preview {
    RecordsScreen()
}
