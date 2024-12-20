//
//  LoginCredentials.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation



public struct LoginCredentials: Codable {

    public var username: String?
    public var password: String?

    public init(username: String? = nil, password: String? = nil) {
        self.username = username
        self.password = password
    }


}
