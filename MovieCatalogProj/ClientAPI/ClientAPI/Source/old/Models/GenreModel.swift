//
//  GenreModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation



public struct GenreModel: Codable {

    public var id: UUID?
    public var name: String?

    public init(id: UUID? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }


}
