//
//  Review.swift
//  MovieCatalog
//
//  Created by Tark Wight on 20.12.2024
//

import Foundation

struct Review {
    let id: UUID
    let rating: Int
    let reviewText: String?
    let isAnonymous: Bool
    let createDateTime: Date
    let author: UserShort?
}
