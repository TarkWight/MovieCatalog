//
//  UserNetworkConfig.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation

enum UserNetworkConfig: NetworkConfig {
    case getProfile
    case updateProfile(Data)

    var path: String {
        "account/"
    }

    var endPoint: String {
        "profile"
    }

    var task: HTTPTask {
        switch self {
        case .getProfile:
            return .request
        case .updateProfile(let data):
            return .requestBody(data)
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getProfile:
            return .get
        case .updateProfile:
            return .put
        }
    }
}
