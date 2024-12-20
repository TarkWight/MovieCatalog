//
//  UserShortModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 15.10.2024.
//

import Foundation



public struct UserShortModel: Codable {

    public var userId: UUID?
    public var nickName: String?
    public var avatar: String?

    public init(userId: UUID? = nil, nickName: String? = nil, avatar: String? = nil) {
        self.userId = userId
        self.nickName = nickName
        self.avatar = avatar
    }


}
