//
//  DateExtension.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation

//MARK: - Date Formtter
extension DateFormatter {
    
    static let longDate = make(format: "MMMM dd, yyyy") ///Eg:  March 04, 2026
    static let longDateTime = make(format: "MMMM dd, yyyy HH:mm:ss") ///Eg:  March 04, 2026 08:30:00
    
    
    
    ///Helper to format date in a given format
    private static func make(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter
    }
}


extension Date {
    var toMMMMddyyyyFormat: String { DateFormatter.longDate.string(from: self) }
    var toMMMMddyyyyHHmmssFormat: String { DateFormatter.longDateTime.string(from: self)}
}
