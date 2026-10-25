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

nonisolated extension FHIRFetching {
    func get<R: Resource>(_ type: R.Type, from url: URL) async throws -> R {
        let data = try  await data(from: url)
        
        do {
            return try JSONDecoder.fhirModelsReadyDecoder().decode(R.self, from: data)
        } catch {
            throw  FHIRNetworkError.decoding(error.localizedDescription)
        }
    }
}
