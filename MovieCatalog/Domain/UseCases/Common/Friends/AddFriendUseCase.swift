//
//  AddFriendUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//


import Foundation

final class AddFriendUseCase {
    private let friendRepository: FriendRepository

    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }

    func execute(user: UserShort) async {
        await friendRepository.saveFriend(friend: user)
    }
}
