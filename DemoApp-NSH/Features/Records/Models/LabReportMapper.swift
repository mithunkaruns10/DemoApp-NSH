//
//  LabReportMapper.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import ModelsR4
import Foundation

//MARK: Mapper from FHIRModels to App level models
nonisolated enum LabReportMapper {
    static func reports(from results: Report) -> [LabReport] {
        let observations = observationsById(results.observations)
        return results.diagnosticReports.compactMap {
                labReport(from: $0, observationByID: observations)
        }
    }
    
    ///Gets Final Report
    static func labReport(from report: DiagnosticReport, observationByID: [String: Observation]) -> LabReport? {
        guard let id = report.id?.value?.string else { return nil }
        let observations = report.result?
            .compactMap(observationId(from:))
            .compactMap { observationByID[$0] }
            .compactMap(labObservation(from:)) ?? []
        return .init(
            id: id,
            title: name(of: report.code),
            date: date(from: report),
            performer: performer(from: report),
            obsercations: observations
        )
    }
    
    ///Gets final Observation
    static func labObservation(from observation: Observation) -> LabObservation? {
        guard let id = observation.id?.value?.string else { return nil }
        
        return .init(
            id: id,
            name: name(of: observation.code),
            value: value(of: observation),
            normalRange: referenceRange(from: observation)
        )
    }
    
    
    static func observationsById(_ observations: [Observation]) -> [String: Observation] {
        let items: [(String, Observation)] = observations.compactMap({
            guard let id = $0.id?.value?.string else { return nil }
            return (id, $0)
        })
        return Dictionary(items, uniquingKeysWith: {first, _ in first })
    }
    
    ///Helper to get reference string from Reference Obj eg: r1 from Observation/r1
    static func observationId(from reference: Reference) -> String? {
        return reference.reference?.value?.string.split(separator: "/").last.map(String.init)
    }
    
    
    //MARK: Other pure function helpers for processing data from parsed data
    
    ///Gets name from Observation
    static func name(of codeableConcept: CodeableConcept) -> String {
        codeableConcept.text?.value?.string ?? "Unknown"
    }
    
    ///Gets value from Observation
    static func value(of observation: Observation) -> String? {
        guard case let .quantity(quantity) = observation.value else { return nil }
        return text(from: quantity)
    }
    
    ///Gets joined text value of quantity value and its unit
    static func text(from quantity: Quantity) -> String? {
        let quantities = [quantity.value?.value?.decimal.description, quantity.unit?.value?.string]
        let joinedText =  quantities.compactMap { $0 }.joined(separator: " ")
        return joinedText.isEmpty ? nil : joinedText
    }
    
    ///Gets referenceRage  text from Observation
    static func referenceRange(from observation: Observation) -> String? {
        guard let range = observation.referenceRange?.first else { return nil }
        
        let lowRange = range.low.flatMap(text(from:))
        let highRange = range.high.flatMap(text(from:))
        
        return switch (lowRange, highRange) {
        case let (low?, high?): String.init(format: "%@ - %@", low, high)
        case let (nil, high?): String.init(format: "≤ %@", high)
        default: nil
        }
    }
    
    ///Gets performer name from DiagnosticReport
    ///Assumed there will be always 1 performer name in Performer Object.
    static func performer(from report: DiagnosticReport) -> String? {
        return report.performer?.first?.display?.value?.string
    }
    
    ///Gets date fromDiagnosticReport
    static func date(from report: DiagnosticReport) -> Date? {
        guard case let .dateTime(dateTime) = report.effective  else { return nil }
        return try? dateTime.value?.asNSDate()
    }
    
    
}
