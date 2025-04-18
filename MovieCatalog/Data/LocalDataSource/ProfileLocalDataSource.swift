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
    func saveProfile(profile: Profile) async {
        let fetchRequest: NSFetchRequest<ProfileEntity> = ProfileEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", profile.id as CVarArg)

        await context.perform {
            do {
                if let existingProfile = try self.context.fetch(fetchRequest).first {
                    existingProfile.nickName = profile.nickName
                    existingProfile.email = profile.email
                    existingProfile.avatarLink = profile.avatarLink
                    existingProfile.name = profile.name
                    existingProfile.birthDate = profile.birthDate
                    existingProfile.gender = profile.gender.rawValue
                } else {
                    let newProfile = ProfileEntity(context: self.context)
                    newProfile.id = profile.id
                    newProfile.nickName = profile.nickName
                    newProfile.email = profile.email
                    newProfile.avatarLink = profile.avatarLink
                    newProfile.name = profile.name
                    newProfile.birthDate = profile.birthDate
                    newProfile.gender = profile.gender.rawValue
                    self.context.insert(newProfile)
                }

                try self.context.save()
            } catch {
                print("Failed to save profile: \(error)")
            }
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
