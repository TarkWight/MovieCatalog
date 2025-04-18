//
//  ReviewEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//

import CoreData


extension ReviewEntity {
    func toDomain() -> Review {
        return Review(
            id: id,
            rating: Int(rating),
            reviewText: reviewText,
            isAnonymous: isAnonymous,
            createDateTime: createDateTime,
            author: author?.toDomain()
        )
    }

    func update(from domain: Review, in context: NSManagedObjectContext) {
        self.id = domain.id
        self.rating = Int32(domain.rating)
        self.reviewText = domain.reviewText
        self.isAnonymous = domain.isAnonymous
        self.createDateTime = domain.createDateTime
        if let userShort = domain.author {
            self.author = UserShortEntity(from: userShort, context: context)
        }
    }
}
