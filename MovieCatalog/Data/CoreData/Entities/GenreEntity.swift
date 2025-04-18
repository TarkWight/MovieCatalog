//
//  GenreEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//


import CoreData

extension GenreEntity {
    func toDomain() -> Genre {
        return Genre(
            id: id,
            name: name,
            isFavorite: false
        )
    }
    
    func update(from domain: Genre, in context: NSManagedObjectContext) {
        self.id = domain.id
        self.name = domain.name
        self.isFavorite = domain.isFavorite
    }
}
