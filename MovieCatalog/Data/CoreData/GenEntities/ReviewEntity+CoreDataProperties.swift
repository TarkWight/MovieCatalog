//
//  ReviewEntity+CoreDataProperties.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//
//

import Foundation
import CoreData


extension ReviewEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewEntity> {
        return NSFetchRequest<ReviewEntity>(entityName: "ReviewEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var rating: Int32
    @NSManaged public var reviewText: String?
    @NSManaged public var isAnonymous: Bool
    @NSManaged public var createDateTime: Date
    @NSManaged public var author: UserShortEntity?

}

extension ReviewEntity : Identifiable {

}
