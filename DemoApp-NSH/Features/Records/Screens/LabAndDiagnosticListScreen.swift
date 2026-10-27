//
//  RecordsListScreen.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import SwiftUI

//MARK:  Lab and Diagnostic Screen
struct LabAndDiagnosticListScreen: View {
    @State private var viewModel = RecordsViewModel()
    @Binding var path: [AppRoute]
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            MainContent(
                path: $path,
                state: viewModel.state
            )
            .onChange(of: viewModel.state, perform: { state in
                if  case .failed = state { showAlert = true }
            })
            .task {
                await viewModel.load()
            }
        }
        .navigationBar(title: "Lab and Diagnostics", isDetails: true)
        .appBackButton()
        .alert("Error", isPresented: $showAlert) {
            Button("Retry") {
                Task { await viewModel.load() }
            }
            Button("Cancel", role: .cancel, action: {
                dismiss()
            })
        } message: {
            if case let .failed(message) = viewModel.state {
                Text(message)
            }
        }
    }
}

//MARK: - Screen main content
struct MainContent: View {
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
                ForEach(labReports) { report in
                    LabAndDiagnosticItem(labReport:report) {
                        path.append(.recordsDetails(report: report))
                    }
                    .padding(.horizontal, 15)
                }
                HStack {
                    Spacer(minLength: 15)
                    Text("End of results")
                        .foregroundColor(Color.gray)
                        .font(.subHeader.bold())
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                    Spacer(minLength: 15)
                }
            }
            
        case let .failed(message):
           Text(message)
                .font(.header)
                .foregroundColor(.primaryTextColor)
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
                observations: [
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
