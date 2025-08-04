//
//  ModalRoute.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

enum ModalRoute: Equatable {
    case addReview(movieID: UUID)
    case error(with: Error)

    static func == (lhs: ModalRoute, rhs: ModalRoute) -> Bool {
        switch (lhs, rhs) {
        case (.addReview(let lhsID), .addReview(let rhsID)):
            return lhsID == rhsID
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.localizedDescription
                == rhsError.localizedDescription

        case (.error(with: _), .addReview(movieID: _)):
            return false
        case (.addReview(movieID: _), .error(with: _)):
            return false
        }
    }
}
