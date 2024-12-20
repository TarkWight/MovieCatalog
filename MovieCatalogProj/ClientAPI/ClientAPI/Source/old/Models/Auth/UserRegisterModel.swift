//
//  UserRegisterModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation



public struct UserRegisterModel: Codable {

    public var userName: String
    public var name: String
    public var password: String
    public var email: String
    public var birthDate: Date?
    public var gender: Gender?

    public init(
        userName: String,
        name: String,
        password: String,
        email: String,
        birthDate: Date? = nil,
        gender: Gender? = nil
    ) {
        self.userName = userName
        self.name = name
        self.password = password
        self.email = email
        self.birthDate = birthDate
        self.gender = gender
    }


}
