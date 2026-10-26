//
//  RecordsListScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

struct LabAndDiagnosticListScreen: View {
    @State private var viewModel = RecordsViewModel()
    @Binding var path: [AppRoute]
    var body: some View {
        ScrollView {
            Content(
                path: $path,
                state: viewModel.state
            )
            .onAppear {
                Task { await viewModel.load() }
            }
        }
        .navigationTitle("Lab and Diagnostics")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - Screen main content
struct Content: View {
    @Binding var path: [AppRoute]
    let state: AppUIState<[LabReport]>
    
    var body: some View {
        ///Screen States
        switch state {
        case .loading:  
            ProgressView()
                .tint(.appColor)
                .progressViewStyle(.circular)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .loaded(labReports):
            VStack(alignment: .leading, spacing: 15) {
                ForEach(labReports, id: \.self) { report in
                    LabAndDiagnosticItem(labReport:report) {
                        path.append(.recordsDetails(report: report))
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 30)
                }
                HStack {
                    Spacer(minLength: 15)
                    Text("End of results")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                    Spacer(minLength: 15)
                }
            }
            
        case let .failed(message):
            EmptyView()
        }
    }
}

#Preview {
    LabAndDiagnosticListScreen(path: .constant(
        [
        .recordsDetails(
            report: .init(
                id: "",
                title: "Test",
                date: Date(),
                performer: "ABC Lab",
                obsercations: [
                    .init(
                        id: "",
                        name: "Ob1",
                        value: "test",
                        normalRange: "10-15"
                    )
                ]
            )
        )
    ]
    )
    )
}
