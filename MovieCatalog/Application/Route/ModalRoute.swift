//
//  ModalRoute.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

enum ModalRoute {
    case addReview(movieID: UUID)
    case error(with: Error)
}
