//
//  ReviewShortModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation



public struct ReviewShortModel: Codable {

    public var id: UUID?
    public var rating: Int?

    public init(id: UUID? = nil, rating: Int? = nil) {
        self.id = id
        self.rating = rating
    }

    
}
