//
//  AppUIState.swift
//  DemoApp-NSH
//
//  Created by Mithun Karun Suma on 25/10/26.
//

//MARK: - Generic UI state for each ViewModels
nonisolated enum AppUIState<Value: Sendable>: Sendable {
    case loading
    case loaded(Value)
    case failed(String)
}


extension AppUIState: Equatable where Value: Equatable {}
