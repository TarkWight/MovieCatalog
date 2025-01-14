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
        return Movie(
            id: id,
            name: name,
            poster: poster,
            year: Int(year),
            country: country,
            genres: (genres as? Set<GenreEntity>)?.map { $0.toDomain() } ?? [],
            reviews: (reviews as? Set<ReviewEntity>)?.map { $0.toDomain() } ?? [],
            time: Int(time),
            tagline: tagline,
            description: movieDescription,
            director: director,
            budget: budget?.intValue,
            fees: Int(fees),
            ageLimit: Int(ageLimit),
            isFavorite: isFavorite
        )
    }
    
    func update(from domain: Movie, in context: NSManagedObjectContext) {
            self.id = domain.id
            self.name = domain.name
            self.poster = domain.poster
            self.year = Int32(domain.year)
            self.country = domain.country
            self.time = Int32(domain.time)
            self.tagline = domain.tagline
            self.movieDescription = domain.description
            self.director = domain.director
            self.budget = domain.budget as NSNumber?
            self.fees = Int32(domain.fees ?? 0)
            self.ageLimit = Int32(domain.ageLimit)
            self.isFavorite = domain.isFavorite

            if let currentGenres = genres as? Set<GenreEntity> {
                for genre in currentGenres {
                    context.delete(genre)
                }
            }
            let genreEntities = domain.genres?.map { genre -> GenreEntity in
                let genreEntity = GenreEntity(context: context)
                genreEntity.update(from: genre, in: context)
                return genreEntity
            }
            genres = NSSet(array: genreEntities ?? [])

            if let currentReviews = reviews as? Set<ReviewEntity> {
                for review in currentReviews {
                    context.delete(review)
                }
            }
            let reviewEntities = domain.reviews?.map { review -> ReviewEntity in
                let reviewEntity = ReviewEntity(context: context)
                reviewEntity.update(from: review, in: context)
                return reviewEntity
            }
            reviews = NSSet(array: reviewEntities ?? [])
        }
}
