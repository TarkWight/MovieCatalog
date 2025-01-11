//
//  MovieLocalDataSource.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation
import CoreData


final class MovieLocalDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.context = context
    }

    @CoreDataActor
    func fetchMovie(id: UUID) async -> MovieEntity? {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        return try? await context.perform {
            try self.context.fetch(fetchRequest).first
        }
    }
    
    @CoreDataActor
    func fetchMovieList() async -> [MovieEntity] {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        return (try? await context.perform {
            try self.context.fetch(fetchRequest)
        }) ?? []
    }
    
    @CoreDataActor
    func saveMovie(_ movie: MovieEntity) async {
        await context.perform {
            self.context.insert(movie)
            try? self.context.save()
        }
    }

    @CoreDataActor
    func deleteMovie(id: UUID) async {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        if let movie = try? await context.perform({
            try self.context.fetch(fetchRequest).first
        }) {
            await context.perform {
                self.context.delete(movie)
                try? self.context.save()
            }
        }
    }

    @CoreDataActor
    func deleteAllMovies() async {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        if let movies = try? await context.perform({
            try self.context.fetch(fetchRequest)
        }) {
            await context.perform {
                for movie in movies {
                    self.context.delete(movie)
                }
                try? self.context.save()
            }
        }
    }

    @CoreDataActor
    func addMovie(_ movie: MovieEntity, update: Bool = false) async {
        await context.perform {
            if update {
                let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", movie.id as CVarArg)

                if let existingEntity = try? self.context.fetch(fetchRequest).first {
                    existingEntity.update(from: movie, context: self.context)
                } else {
                    let _ = MovieEntity(context: self.context)
                    movie.update(from: movie, context: self.context)
                }
            } else {
                let _ = MovieEntity(context: self.context)
                movie.update(from: movie, context: self.context)
            }

            do {
                try self.context.save()
            } catch {
                print("Failed to add or update movie: \(error.localizedDescription)")
            }
        }
    }
}
