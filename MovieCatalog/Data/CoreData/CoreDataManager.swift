//
//  CoreDataManager.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    private let persistentContainer: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieCatalog")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}

extension CoreDataManager {
    func clearDatabase() {
        let context = persistentContainer.viewContext
        let entities = persistentContainer.managedObjectModel.entities

        entities.forEach { entity in
            guard let entityName = entity.name else { return }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print("Failed to clear entity \(entityName): \(error.localizedDescription)")
            }
        }
    }
}
