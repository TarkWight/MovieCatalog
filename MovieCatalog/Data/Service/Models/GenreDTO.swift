//
//  GenreDTO.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation



public struct GenreDTO: Codable {

    public var id: UUID
    public var name: String?

   func toDomain() -> Genre {
       .init(id: id, name: name)
    }
}
