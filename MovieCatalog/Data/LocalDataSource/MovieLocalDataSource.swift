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
    func fetchMovie(id: UUID) async -> Movie? {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        if let entity = try? await context.perform({
            try self.context.fetch(fetchRequest).first
        }) {
            return entity.toDomain()
        }
        return nil
    }

    @CoreDataActor
    func fetchMovieList() async -> [Movie] {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let entities = (try? await context.perform {
            try self.context.fetch(fetchRequest)
        }) ?? []
        return entities.map { $0.toDomain() }
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
        let movies = (try? await context.perform {
            try self.context.fetch(fetchRequest)
        }) ?? []
        await context.perform {
            for movie in movies {
                self.context.delete(movie)
            }
            try? self.context.save()
        }
    }

    @CoreDataActor
    func saveMovie(_ domain: Movie) async {
        await context.perform {
            let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", domain.id as CVarArg)

            let movieEntity: MovieEntity
            if let existingEntity = try? self.context.fetch(fetchRequest).first {
                movieEntity = existingEntity
            } else {
                movieEntity = MovieEntity(context: self.context)
            }

            movieEntity.update(from: domain, in: self.context)
            do {
                try self.context.save()
            } catch let error as NSError {
                print("Failed to save movie: \(error.localizedDescription)")
                if let detailedErrors = error.userInfo[NSDetailedErrorsKey] as? [NSError] {
                    for detailedError in detailedErrors {
                        print("Detailed error: \(detailedError.localizedDescription)")
                    }
                } else {
                    print("Core Data error details: \(error.userInfo)")
                }
            }
        }
    }
}
