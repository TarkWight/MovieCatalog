//
//  ViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import Foundation

@MainActor
protocol ViewModel<Event>: AnyObject {
    associatedtype Event

    func handle(_ event: Event)
}
