//
//  MovieNetworkConfig.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

enum MovieNetworkConfig: NetworkConfig {
    case listByPage(Int)
    case detailsById(UUID)

    var path: String {
        "movies/"
    }

    var endPoint: String {
        switch self {
        case .listByPage(let page):
            return "\(page)"
        case .detailsById(let id):
            return "details/" + id.uuidString
        }
    }

    var task: HTTPTask {
        .request
    }

    var method: HTTPMethod {
        .get
    }
}
