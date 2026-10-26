//
//  AppRoute.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

import Foundation

//MARK: Router
enum AppRoute: Hashable, Sendable {
    case labAndDiagnostic
    case recordsDetails(report: LabReport)
}
