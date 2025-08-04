//
//  FullScreenModalRoute.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

enum FullScreenModalRoute {
    case movieDetails(movieID: UUID)
    case friends
    case collection(tag: UUID)
}
