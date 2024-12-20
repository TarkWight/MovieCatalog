//
//  AuthResponseModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 20.10.2024.
//

import Foundation


public struct AuthResponseModel: Codable {
    public let token: String?
    
    public init(token: String?) {
        self.token = token
    }
}
