//
//  FriendRepositoryImplementation.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class FriendRepositoryImplementation {
    private let localDataSource: FriendLocalDataSource

    init(localDataSource: FriendLocalDataSource) {
        self.localDataSource = localDataSource
    }
}

extension FriendRepositoryImplementation: FriendRepository {
    func fetchAllFriends() async -> [UserShort] {
            let friendEntities = await localDataSource.fetchAllFriends()
            return friendEntities.map { $0.toDomain() }
    
    }

    func saveFriend(friend: UserShort) async {
        let context = CoreDataManager.shared.viewContext
                   let friendEntity = UserShortEntity(from: friend, context: context)
             await localDataSource.saveFriend(friendEntity)
    }

    func deleteFriend(by id: UUID) async {
        await localDataSource.deleteFriend(by: id)
    }
}
