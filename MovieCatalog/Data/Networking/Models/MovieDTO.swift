//
//  MovieDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

struct MovieDTO: Decodable {
    let id: UUID
    let name: String?
    let poster: String?
    let year: Int
    let country: String?
    let genres: [GenreDTO]?
    let reviews: [ReviewDTO]?
    let time: Int
    let tagline: String?
    let description: String?
    let director: String?
    let budget: Int?
    let fees: Int?
    let ageLimit: Int

    func toDomain() -> Movie {
        .init(
            id: id,
            name: name,
            poster: poster,
            year: year,
            country: country,
            genres: genres?.map { $0.toDomain() },
            reviews: reviews?.map { $0.toDomain() },
            time: time,
            tagline: tagline,
            description: description,
            director: director,
            budget: budget,
            fees: fees,
            ageLimit: ageLimit
        )
    }
}
