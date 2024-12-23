//
//  ProfileModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 04.11.2024.
//

import Foundation

public struct ProfileModel: Codable {

    public var id: UUID?
    public var nickName: String?
    public var email: String
    public var avatarLink: String?
    public var name: String
    public var birthDate: Date
    public var gender: GenderDTO?

    public init(id: UUID? = nil, nickName: String? = nil, email: String, avatarLink: String? = nil, name: String, birthDate: Date, gender: GenderDTO? = nil) {
        self.id = id
        self.nickName = nickName
        self.email = email
        self.avatarLink = avatarLink
        self.name = name
        self.birthDate = birthDate
        self.gender = gender
    }
    

}
