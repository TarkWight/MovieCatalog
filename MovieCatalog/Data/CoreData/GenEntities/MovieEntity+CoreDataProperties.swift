//
//  MovieEntity+CoreDataProperties.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var poster: String?
    @NSManaged public var year: Int32
    @NSManaged public var country: String?
    @NSManaged public var time: Int32
    @NSManaged public var tagline: String?
    @NSManaged public var movieDescription: String?
    @NSManaged public var director: String?
    @NSManaged public var budget: Int32
    @NSManaged public var fees: Int32
    @NSManaged public var ageLimit: Int32
    @NSManaged public var isFavorite: Bool
    @NSManaged public var genres: NSSet?
    @NSManaged public var reviews: NSSet?

}

// MARK: Generated accessors for genres
extension MovieEntity {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreEntity)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreEntity)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

// MARK: Generated accessors for reviews
extension MovieEntity {

    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: ReviewEntity)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: ReviewEntity)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}

extension MovieEntity : Identifiable {

}
