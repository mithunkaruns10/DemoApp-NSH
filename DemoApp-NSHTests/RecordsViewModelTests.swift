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
    
    private var dateTest: Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return formatter.date(from: "2011-03-03 21:30:00 +0000")
    }
    
    ///Test Lab and Diagnostic report
    @Test func loadDiagnosticReport() async {
        
        let viewModel = RecordsViewModel(
            endPoint: .diagnosticReport,
            client: MockReportFetching(result: .success(Self.mockData))
        )
        
        await viewModel.load()
        
        let expectedValue = AppUIState.loaded([
            LabReport.init(
                id: "101",
                title: "Complete Blood Count",
                date:  dateTest,
                performer: Optional("Acme Laboratory, Inc"),
                observations: [
                    .init(
                        id: "r1",
                        name: "Haematocrit",
                        value: Optional("55 %"),
                        normalRange: Optional("38 % - 52 %")
                    )])
        ])
        
        let actualValue = viewModel.state
        
        #expect(actualValue == expectedValue)
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
              "resourceType" : "Bundle",
              "id" : "101",
              "type" : "collection",
              "entry" : [{
                "fullUrl" : "https://example.com/base/DiagnosticReport/101",
                "resource" : {
                  "resourceType" : "DiagnosticReport",
                  "id" : "101",
                  "meta" : {
                    "tag" : [{
                      "system" : "http://example.org/fhir/CodeSystem/workflow-codes",
                      "code" : "01",
                      "display" : "Needs Review"
                    }]
                  },
                  "text" : {
                    "status" : "generated",
                    "div" : ""
                  },
                  "identifier" : [{
                    "system" : "http://acme.com/lab/reports",
                    "value" : "5234342"
                  }],
                  "status" : "final",
                  "category" : [{
                    "coding" : [{
                      "system" : "http://terminology.hl7.org/CodeSystem/v2-0074",
                      "code" : "HM"
                    }]
                  }],
                  "code" : {
                    "coding" : [{
                      "system" : "http://loinc.org",
                      "code" : "58410-2",
                      "display" : "CBC panel - Blood by Automated count"
                    },
                    {
                      "code" : "CBC",
                      "display" : "MASTER FULL BLOOD COUNT"
                    }],
                    "text" : "Complete Blood Count"
                  },
                  "subject" : {
                    "reference" : "Patient/pat2"
                  },
                  "encounter" : {
                    "reference" : "Encounter/example"
                  },
                  "effectiveDateTime" : "2011-03-04T08:30:00+11:00",
                  "issued" : "2011-03-04T08:30:00+11:00",
                  "performer" : [{
                    "reference" : "Organization/1832473e-2fe0-452d-abe9-3cdb9879522f",
                    "display" : "Acme Laboratory, Inc"
                  }],
                  "result" : [{
                    "reference" : "Observation/r1"
                  }],
                    "presentedForm" : [{}]
                }
              },
                  {
                "fullUrl" : "https://example.com/base/Observation/r3",
                "resource" : {
                  "resourceType" : "Observation",
                  "id" : "r1",
                  "text" : {
                    "status" : "generated",
                    "div" : ""
                  },
                  "status" : "final",
                  "code" : {
                    "coding" : [{
                      "system" : "http://loinc.org",
                      "code" : "4544-3",
                      "display" : "Hematocrit [Volume Fraction] of Blood by Automated count"
                    }],
                    "text" : "Haematocrit"
                  },
                  "subject" : {
                    "reference" : "Patient/pat2"
                  },
                  "performer" : [{
                    "reference" : "Organization/1832473e-2fe0-452d-abe9-3cdb9879522f",
                    "display" : "Acme Laboratory, Inc"
                  }],
                  "valueQuantity" : {
                    "value" : 55,
                    "unit" : "%"
                  },
                  "interpretation" : [{
                    "coding" : [{
                      "system" : "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation",
                      "code" : "H"
                    }]
                  }],
                  "referenceRange" : [{
                    "low" : {
                      "value" : 38,
                      "unit" : "%"
                    },
                    "high" : {
                      "value" : 52,
                      "unit" : "%"
                    }
                  }]
                }
              }]
            }
        """.utf8
    )
}


