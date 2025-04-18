//
//  GenreDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

struct GenreDTO: Decodable {
    let id: UUID
    let name: String?

    func toDomain() -> Genre {
        .init(id: id, name: name)
    }
}
