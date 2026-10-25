//
//  FHIREndpoint.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation

//MARK: - API Endpoints
nonisolated enum FHIREndpoint: Sendable {
    static let baseURL = "https://build.fhir.org"
    
    
    case diagnosticReport
    
    
    var path: String {
        switch self {
        case .diagnosticReport: "/diagnosticreport-example.json"
        }
    }
    
    var url: URL? { URL(string: Self.baseURL + path) }
}
