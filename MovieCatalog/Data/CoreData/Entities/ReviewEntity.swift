//
//  ReviewEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//


//import CoreData
//
//@objc(ReviewEntity)
//final class ReviewEntity: NSManagedObject {
//    @NSManaged var id: UUID
//    @NSManaged var rating: Int32
//    @NSManaged var reviewText: String?
//    @NSManaged var isAnonymous: Bool
//    @NSManaged var createDateTime: Date
//    @NSManaged var author: UserShortEntity?
//}
//
extension ReviewEntity {
    func toDomain() -> Review {
        Review(
            id: id,
            rating: Int(rating),
            reviewText: reviewText,
            isAnonymous: isAnonymous,
            createDateTime: createDateTime,
            author: author?.toDomain()
        )
    }
}
//
//    func update(from review: Review, context: NSManagedObjectContext) {
//        id = review.id
//        rating = Int32(review.rating)
//        reviewText = review.reviewText
//        isAnonymous = review.isAnonymous
//        createDateTime = review.createDateTime
//        if let author = review.author {
//            self.author = author.toEntity(context: context)
//        }
//    }
//}
//
//extension Review {
//    func toEntity(context: NSManagedObjectContext) -> ReviewEntity {
//        let entity = ReviewEntity(context: context)
//        entity.id = id
//        entity.rating = Int32(rating)
//        entity.reviewText = reviewText
//        entity.isAnonymous = isAnonymous
//        entity.createDateTime = createDateTime
//        entity.author = author?.toEntity(context: context)
//        return entity
//    }
//}
