//
//  FHIRClient.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation

//MARK: - Network client - API Calls
nonisolated  struct FHIRClient: FHIRFetching, Sendable {
    var headers: [String: String]
    let httpMethod: HTTPMethod
    private let load: @Sendable (URLRequest) async throws -> (Data, URLResponse)
    
    ///Dependency injection 
    init(
        headers: [String : String] = [:],
        httpMethod: HTTPMethod = .GET,
        load: @Sendable @escaping (URLRequest) async throws -> (Data, URLResponse) = { try await URLSession.shared.data(for: $0)}
    ) {
        self.headers = headers
        self.httpMethod = httpMethod
        self.load = load
    }
    
    func data(from url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/fhir+json", forHTTPHeaderField: "Accept")
        
        for (key, value) in  headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let (data, response) = try await load(request)
        
        guard let http = response as? HTTPURLResponse else {
            throw FHIRNetworkError.invalidResponse
        }
        
        guard (200..<300).contains(http.statusCode) else {
            throw FHIRNetworkError.statusCode(http.statusCode, data)
        }
        
        return data
    }
}
