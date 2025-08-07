//
//  Gender.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

enum Gender: String, Identifiable, CaseIterable {
    case male
    case female

    var id: UUID {
        switch self {
        case .male:
            return UUID(uuidString: "11111111-1111-1111-1111-111111111111")
                ?? UUID.init()
        case .female:
            return UUID(uuidString: "22222222-2222-2222-2222-222222222222")
                ?? UUID.init()
        }
    }
}
