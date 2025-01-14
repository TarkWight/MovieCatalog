//
//  UserShortEntity+CoreDataProperties.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//
//

import Foundation
import CoreData


extension UserShortEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserShortEntity> {
        return NSFetchRequest<UserShortEntity>(entityName: "UserShortEntity")
    }

    @NSManaged public var userId: UUID?
    @NSManaged public var nickName: String?
    @NSManaged public var avatarLink: String?

}

extension UserShortEntity : Identifiable {

}
