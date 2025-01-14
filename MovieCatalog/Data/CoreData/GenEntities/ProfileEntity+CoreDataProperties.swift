//
//  ProfileEntity+CoreDataProperties.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//
//

import Foundation
import CoreData


extension ProfileEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileEntity> {
        return NSFetchRequest<ProfileEntity>(entityName: "ProfileEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var nickName: String
    @NSManaged public var email: String
    @NSManaged public var avatarLink: String
    @NSManaged public var name: String
    @NSManaged public var birthDate: Date
    @NSManaged public var gender: String

}

extension ProfileEntity : Identifiable {

}
