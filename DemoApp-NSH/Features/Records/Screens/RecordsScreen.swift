//
//  ReportScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct RecordsScreen: View {
    @State private var path: [AppRoute] = []
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                ForEach(0..<5) {_ in
                    RecordsListItem {
                        path.append(.labAndDiagnostic)
                    }
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle(AppTab.records.title)
            .navigationDestination(for: AppRoute.self) { route in
                Group {
                    switch route {
                    case .labAndDiagnostic:
                        LabAndDiagnosticListScreen(path: $path)
                    case .recordsDetails:
                        RecordDetailsScreen()
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
