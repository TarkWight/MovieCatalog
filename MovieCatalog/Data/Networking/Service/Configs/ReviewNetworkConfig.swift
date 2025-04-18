//
//  ReviewNetworkConfig.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation

enum ReviewNetworkConfig: NetworkConfig {
    case add(movieId: UUID, review: Data)
    case delete(movieId: UUID, reviewId: UUID)
    case edit(movieId: UUID, reviewId: UUID, review: Data)

    var path: String {
        "movie/"
    }

    var endPoint: String {
        switch self {
        case .add(let movieId, _):
            return movieId.uuidString + "/review/add"
        case .delete(let movieId, let reviewId):
            return movieId.uuidString + "/review/" + reviewId.uuidString + "/delete"
        case .edit(let movieId, let reviewId, _):
            return movieId.uuidString + "/review/" + reviewId.uuidString + "/edit"
        }
    }

    var task: HTTPTask {
        switch self {
        case .delete:
            return .request
        case .add(_, let review):
            return .requestBody(review)
        case .edit(_, _, let review):
            return .requestBody(review)
        }
    }

    var method: HTTPMethod {
        switch self {
        case .add:
            return .post
        case .edit:
            return .put
        case .delete:
            return .delete
        }
    }
}
