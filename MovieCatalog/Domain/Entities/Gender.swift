//
//  Gender.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male
    case female

    var id: String {
        rawValue
    }
}
