//
//  LabReport.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation


nonisolated struct LabReport: Identifiable, Sendable, Hashable {
    let id:  String
    let title: String
    let date:  Date?
    let performer: String?
    let obsercations: [LabObservation]
}
