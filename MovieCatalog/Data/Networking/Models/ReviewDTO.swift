//
//  ReviewDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//


import Foundation

struct ReviewDTO: Decodable {
    let id: UUID
    let rating: Int
    let reviewText: String?
    let isAnonymous: Bool
    let createDateTime: String
    let author: UserShortDTO?

    func toDomain() -> Review {
        .init(
            id: id,
            rating: rating,
            reviewText: reviewText,
            isAnonymous: isAnonymous,
            createDateTime: DateFormatter.iso8601FullWithMs.date(from: createDateTime) ?? .now,
            author: author?.toDomain()
        )
    }
}
