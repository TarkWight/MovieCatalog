//
//  ReviewShortDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

struct ReviewShortDTO: Decodable {
    let id: UUID
    let rating: Int

    func toDomain() -> ReviewShort {
        .init(id: id, rating: rating)
    }
}
