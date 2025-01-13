//
//  GenreEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//


import CoreData

extension GenreEntity {
    func toDomain() -> Genre {
        Genre(id: id, name: name)
    }

    func update(from genre: Genre) {
        id = genre.id
        name = genre.name
    }
}
//
//extension Genre {
//    func toEntity(context: NSManagedObjectContext) -> GenreEntity {
//        let entity = GenreEntity(context: context)
//        entity.id = id
//        entity.name = name
//        return entity
//    }
//}
