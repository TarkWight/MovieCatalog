//
//  UserShortDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//


import Foundation

struct UserShortDTO: Decodable {
    let userId: UUID
    let nickName: String?
    let avatar: String?

    func toDomain() -> UserShort {
        .init(userId: userId, nickName: nickName, avatar: avatar)
    }
}
