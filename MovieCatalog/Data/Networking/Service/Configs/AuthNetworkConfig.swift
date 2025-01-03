//
//  AuthNetworkConfig.swift
//  MovieCatalog
//
//  Created by Tark Wight on 03.01.2025.
//

import Foundation

enum AuthNetworkConfig: NetworkConfig {
    case logout
    case login(Data)
    case register(Data)
    
    var path: String {
        "/account"
    }
    
    var endPoint: String {
        switch self {
        case .logout:   return "logout"
        case .login:    return "login"
        case .register: return "register"
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .logout:               return .request
        case .login(let data):      return .requestBody(data)
        case .register(let data):   return .requestBody(data)
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    
}
