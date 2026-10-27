//
//  AppTab.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 24/10/26.
//

//MARK: Tab selection handling
enum AppTab: String, Sendable, Hashable {
    case home, records
    
    init?(rawIndex: Int) {
        switch rawIndex {
        case 0: self = .home
        case 1: self = .records
        default:
            assertionFailure("Unknown tab selection\(rawIndex)")
            return nil
        }
    }
    
    ///Tab titles
    var title: String {
        switch self {
        case .home: "Home"
        case .records: "Records"
        }
    }
}
