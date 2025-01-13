//
//  MovieEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation
import CoreData

extension MovieEntity {
    func toDomain() -> Movie {
        Movie(
            id: id,
            name: name,
            poster: poster,
            year: Int(year),
            country: country,
            genres: (genres?.allObjects as? [GenreEntity])?.map { $0.toDomain() },
            reviews: (reviews?.allObjects as? [ReviewEntity])?.map { $0.toDomain() },
            time: Int(time),
            tagline: tagline,
            description: movieDescription,
            director: director,
            budget: Int(truncating: budget ?? -1),
            fees: Int(fees),
            ageLimit: Int(ageLimit),
            isFavorite: isFavorite
        )
    }

    func update(from movieEntity: MovieEntity, context: NSManagedObjectContext) {
        id = movieEntity.id
        name = movieEntity.name
        poster = movieEntity.poster
        year = movieEntity.year
        country = movieEntity.country
        time = movieEntity.time
        tagline = movieEntity.tagline
        movieDescription = movieEntity.movieDescription
        director = movieEntity.director
        budget = movieEntity.budget
        fees = movieEntity.fees
        ageLimit = movieEntity.ageLimit
        isFavorite = movieEntity.isFavorite

        if let genres = movieEntity.genres as? Set<GenreEntity> {
            self.genres = NSSet(set: genres)
        }

        if let reviews = movieEntity.reviews as? Set<ReviewEntity> {
            self.reviews = NSSet(set: reviews)
        }
    }
}
