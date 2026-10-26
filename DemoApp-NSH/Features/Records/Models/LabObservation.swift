//
//  LabObservation.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation


nonisolated struct LabObservation: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let value: String?
    let normalRange: String?
}
