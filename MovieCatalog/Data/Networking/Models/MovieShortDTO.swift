//
//  MovieShortDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

struct MovieShortDTO: Decodable {
    let id: UUID
    let name: String?
    let poster: String?
    let year: Int
    let country: String?
    let genres: [GenreDTO]?
    let reviews: [ReviewShortDTO]?

    func toDomain() -> MovieShort {
        .init(
            id: id,
            name: name,
            poster: poster,
            year: year,
            country: country,
            genres: genres?.map { $0.toDomain() },
            reviews: reviews?.map { $0.toDomain() }
        )
    }
}

struct MoviesResponse: Decodable {
    let movies: [MovieShortDTO]
}

struct MoviesPagedResponse: Decodable {
    let movies: [MovieShortDTO]
    let pageInfo: PageInfoDTO

    struct PageInfoDTO: Decodable {
        let pageSize: Int
        let pageCount: Int
        let currentPage: Int
    }
}
