//
//  FHIRNetworkError.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation

//MARK: - Network Errors
nonisolated enum FHIRNetworkError: Error, Sendable {
    case invalidResponse
    case statusCode(Int, Data)
    case decoding(String)
    case unknown(String)
}
