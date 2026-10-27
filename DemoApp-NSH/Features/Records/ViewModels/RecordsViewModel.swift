//
//  RecordsViewModel.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation
import Observation

//MARK: - Observable Records viewModel

@MainActor
@Observable
final class RecordsViewModel {
    
    private(set) var state: AppUIState<[LabReport]> = .loading
    
    private let endPoint: FHIREndpoint
    private let client: any FHIRFetching
    
    init(
        endPoint: FHIREndpoint = .diagnosticReport,
        client: any FHIRFetching = FHIRClient()
    ) {
        self.endPoint = endPoint
        self.client = client
    }
    
    
    //MARK: - Function to load records
    
    func load() async {
        state = .loading
        do {
            guard let url = endPoint.url else {
               assertionFailure("Invalid Url")
                state = .failed("Invalid Url")
                return
            }
            let results = try await  client.reports(from: url)
            let mappedReport = LabReportMapper.reports(from: results)
            state = .loaded(mappedReport)
        } catch {
            state = .failed("Something went wrong, Please try again")
        }
    }
}
