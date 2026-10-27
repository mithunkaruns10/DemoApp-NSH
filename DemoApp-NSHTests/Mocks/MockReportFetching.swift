//
//  MockReportFetching.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 26/10/26.
//

import Foundation


//MARK: Mock for Unit testing
nonisolated struct MockReportFetching: FHIRFetching {
    let result: Result<Data, any Error>
    func data(from url: URL) async throws -> Data {
        try result.get()
    }
    
}
