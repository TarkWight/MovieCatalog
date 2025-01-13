//
//  Genre.swift
//  MovieCatalog
//
//  Created by Tark Wight on 20.12.2024
//

import Foundation

struct Genre: Equatable, Hashable {
    let id: UUID
    let name: String?
    var isFavorite: Bool = false
}
