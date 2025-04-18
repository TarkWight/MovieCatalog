//
//  FetchFriendsUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class FetchFriendsUseCase {
    private let friendRepository: FriendRepository

    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }

    func execute() async throws -> [UserShort] {
        await friendRepository.fetchAllFriends()
    }
}



