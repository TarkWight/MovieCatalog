//
//  ReviewModifyDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//


import Foundation

struct ReviewModifyDTO: Encodable {
    let reviewText: String
    let rating: Int
    let isAnonymous: Bool
}
