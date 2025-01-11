//
//  RemoveFriendUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class RemoveFriendUseCase {
    private let friendRepository: FriendRepository

    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }

    func execute(friendId: UUID) async throws {
        await friendRepository.deleteFriend(by: friendId)
    }
}
