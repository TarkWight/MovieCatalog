//
//  MovieDetailsModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 15.10.2024.
//

import Foundation



public struct MovieDetailsModel: Codable {

    public var id: UUID?
    public var name: String?
    public var poster: String?
    public var year: Int?
    public var country: String?
    public var genres: [GenreModel]?
    public var reviews: [ReviewModel]?
    public var time: Int?
    public var tagline: String?
    public var description: String?
    public var director: String?
    public var budget: Int?
    public var fees: Int?
    public var ageLimit: Int?

    public init(
        id: UUID? = nil,
        name: String? = nil,
        poster: String? = nil,
        year: Int? = nil,
        country: String? = nil,
        genres: [GenreModel]? = nil,
        reviews: [ReviewModel]? = nil,
        time: Int? = nil,
        tagline: String? = nil,
        description: String? = nil,
        director: String? = nil,
        budget: Int? = nil,
        fees: Int? = nil,
        ageLimit: Int? = nil
    ) {
        self.id = id
        self.name = name
        self.poster = poster
        self.year = year
        self.country = country
        self.genres = genres
        self.reviews = reviews
        self.time = time
        self.tagline = tagline
        self.description = description
        self.director = director
        self.budget = budget
        self.fees = fees
        self.ageLimit = ageLimit
    }


}
