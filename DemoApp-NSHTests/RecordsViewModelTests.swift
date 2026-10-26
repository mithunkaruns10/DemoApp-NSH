//
//  RecordsViewModelTests.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 26/10/26.
//

import Testing
@testable import DemoApp_NSH
import Foundation

@MainActor
struct RecordsViewModelTests {
        
    ///Test Lab and Diagnostic report
    @Test func loadDiagnosticReport() async {
        
        let viewModel = RecordsViewModel(
            endPoint: .diagnosticReport,
            client: MockReportFetching(result: .success(Self.mockData))
        )

        await viewModel.load()
        
        #expect(viewModel.state == .loaded([
            LabReport(
                id: "101",
                title: "Complete Blood Count",
                date: ISO8601DateFormatter().date(from: "2011-03-04T08:30:00+11:00"),
                performer: "Acme Laboratory, Inc",
                obsercations: [
                    .init(
                        id: "r1",
                        name: "Haemoglobin",
                        value: "6.2 g/dL",
                        normalRange: "≤ 11 g/dL"
                    )
                ])
        ]))
    }
    
    //Test Lab and Diagnostic report failure
    @Test func loadFailedDiagnosticRepost() async {
        let viewModel = RecordsViewModel(
            endPoint: .diagnosticReport,
            client: MockReportFetching(result: .failure(FHIRNetworkError.statusCode(500, Data())))
        )
        await viewModel.load()
        
        #expect(viewModel.state == .failed("Something went wrong, Please try again"))
    }
    
    
    
    
    //MARK: MOCK Data
  static  let mockData = Data (
        """
            {
              "resourcetype": "Bundle",
              "type": "collection",
              "entry": [
                {
                  "resource": {
                    "resourceType": "DiagnosticReport",
                    "id": "101",
                    "status": "final",
                    "code": {
                      "text": "Complete Blood Count"
                    },
                    "effectiveDatetime": "2011-03-04T08:30:00+11:00",
                    "performer": [
                      {
                        "display": "Acme Laboratory, Inc"
                      }
                    ],
                    "result": [
                      {
                        "reference": "Observation/r1"
                      },
                      {
                        "reference": "Observation/r2"
                      }
                    ]
                  }
                },
                {
                  "resource": {
                    "resourceType": "Observation",
                    "id": "r1",
                    "status": "final",
                    "code": {
                      "text": "Haemoglobin"
                    },
                    "valueQuantity": {
                      "value": "6.2",
                      "unit": "g/dL"
                    },
                    "referenceRange": [
                      {
                        "high": {
                          "value": "11",
                          "unit": "g/dL"
                        }
                      }
                    ]
                  }
                }
              ]
            }
        """.utf8
    )

}

