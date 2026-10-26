//
//  DateFormatterTests.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 26/10/26.
//

import Testing
@testable import DemoApp_NSH
import Foundation

@MainActor
struct DateFormatterTests {
    private let date = Calendar.current.date(
        from: DateComponents(year: 2026, month:3, day:4, hour:8, minute:30)
    )
    
    
    @Test func longDateText() {
        #expect(date?.toMMMMddyyyyFormat ?? "" == "March 04, 2026")
    }
    
    @Test func longDateTimeText() {
        #expect(date?.toMMMMddyyyyHHmmssFormat ?? "" == "March 04, 2026 08:30:00")
    }
}
