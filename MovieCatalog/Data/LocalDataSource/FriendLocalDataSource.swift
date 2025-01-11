//
//  FriendLocalDataSource.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//


import Foundation
import CoreData

final class FriendLocalDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.context = context
    }

    @CoreDataActor
    func fetchAllFriends() async -> [UserShortEntity] {
        let fetchRequest: NSFetchRequest<UserShortEntity> = UserShortEntity.fetchRequest()

        return await context.perform {
            (try? self.context.fetch(fetchRequest)) ?? []
        }
    }

    @CoreDataActor
    func saveFriend(_ friend: UserShortEntity) async {
        await context.perform {
            self.context.insert(friend)
            try? self.context.save()
        }
    }

    @CoreDataActor
    func deleteFriend(by id: UUID) async {
        let fetchRequest: NSFetchRequest<UserShortEntity> = UserShortEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", id as CVarArg)

        await context.perform {
            if let friend = try? self.context.fetch(fetchRequest).first {
                self.context.delete(friend)
                try? self.context.save()
            }
        }
    }
}
