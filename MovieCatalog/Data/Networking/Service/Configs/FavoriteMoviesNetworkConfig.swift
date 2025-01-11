//
//  FavoriteMoviesNetworkConfig.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation

enum FavoriteMoviesNetworkConfig: NetworkConfig {
    case list
    case add(movieId: UUID)
    case delete(movieId: UUID)

    var path: String {
        "favorites/"
    }

    var endPoint: String {
        switch self {
        case .list:
            return ""
        case .add(let movieId):
            return movieId.uuidString + "/add"
        case .delete(let movieId):
            return movieId.uuidString + "/delete"
        }
    }

    var task: HTTPTask {
        return .request
    }

    var method: HTTPMethod {
        switch self {
        case .list:
            return .get
        case .add:
            return .post
        case .delete:
            return .delete
        }
    }
}
