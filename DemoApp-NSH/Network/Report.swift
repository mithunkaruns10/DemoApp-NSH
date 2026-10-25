//
//  Records.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import ModelsR4
import Foundation
import FMCore

nonisolated struct Report: Sendable {
    let diagnosticReports: [DiagnosticReport]
    let observation: [Observation]
    
    
    ///Helper to parse the FHIR data
    static func parse(_ data: Data) throws -> Report {
        let proxy: ResourceProxy
        
        do {
            proxy = try JSONDecoder.fhirModelsReadyDecoder().decode(ResourceProxy.self, from: data)
        } catch {
            throw FHIRNetworkError.decoding(error.localizedDescription)
        }
        
        switch proxy {
        case let .bundle(bundle):
            let diagnosticReport = bundle.entry?.compactMap {
                $0.resource?.get(if: DiagnosticReport.self)
            } ?? []
            let observarion = bundle.entry?.compactMap {
                $0.resource?.get(if: Observation.self)
            } ?? []
            
            let contained =  diagnosticReport.flatMap {
                $0.contained?.compactMap {
                    $0.get(if: Observation.self)
                } ?? []
            }
            return Report(diagnosticReports: diagnosticReport, observation: observarion + contained)
        case let .diagnosticReport(diagnosticReport):
            let contained = diagnosticReport.contained?.compactMap {
                $0.get(if: Observation.self)
            } ?? []
            return Report(diagnosticReports: [diagnosticReport], observation: contained)
        default:
            throw FHIRNetworkError.unknown("Unexpected type")
        }
    }
}


/// GET and reads reports from FHIR JSOn
nonisolated extension FHIRFetching {
    func reports(from url: URL) async throws -> Report {
       try Report.parse(try await data(from: url))
    }
}
