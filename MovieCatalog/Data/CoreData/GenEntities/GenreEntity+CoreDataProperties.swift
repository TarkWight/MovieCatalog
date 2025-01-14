//
//  GenreEntity+CoreDataProperties.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//
//

import Foundation
import CoreData


extension GenreEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreEntity> {
        return NSFetchRequest<GenreEntity>(entityName: "GenreEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var isFavorite: Bool
}

extension GenreEntity : Identifiable {

}
