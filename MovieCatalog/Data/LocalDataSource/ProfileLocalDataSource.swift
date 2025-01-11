//
//  ProfileLocalDataSource.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation
import CoreData

final class ProfileLocalDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.context = context
    }

    @CoreDataActor
    func fetchProfile() async -> ProfileEntity? {
        let fetchRequest: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        return try? await context.perform {
            try self.context.fetch(fetchRequest).first
        }
    }

    @CoreDataActor
    func saveProfile(_ profile: ProfileEntity) async {
        await context.perform {
            self.context.insert(profile)
            try? self.context.save()
        }
    }

    @CoreDataActor
    func deleteProfile() async {
        let fetchRequest: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()

        if let profile = try? await context.perform({
            try self.context.fetch(fetchRequest).first
        }) {
            await context.perform {
                self.context.delete(profile)
                try? self.context.save()
            }
        }
    }
}
