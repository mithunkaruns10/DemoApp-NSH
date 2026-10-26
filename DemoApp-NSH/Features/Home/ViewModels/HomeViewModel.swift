//
//  HomeViewModel.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

import Foundation
import Observation


final class  HomeViewModel: Sendable {
    private(set) var state: AppUIState<Home> = .loading
    
    init(state: AppUIState<Home> = .loaded(.init(title: "Demp App"))) {
        self.state = state
    }
}
