//
//  FHIRFetching.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation
import ModelsR4
import FMCore


//MARK: Protocol to decode required R4 model
nonisolated protocol FHIRFetching: Sendable {
    func data(from url: URL) async throws -> Data
}
