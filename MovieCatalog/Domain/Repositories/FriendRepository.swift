//
//  FriendRepository.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

protocol FriendRepository {
    func fetchAllFriends() async -> [UserShort]
    func saveFriend(friend: UserShort) async
    func deleteFriend(by id: UUID) async
}
