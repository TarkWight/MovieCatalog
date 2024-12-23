//
//  NetworkConfig.swift
//  ClientAPI
//
//  Created by Tark Wight on 20.12.2024.
//

import Foundation

protocol NetworkConfig {
    var path: String { get }
    var endPoint: String { get }
    var task: HTTPTask { get }
    var method: HTTPMethod { get }
    var useToken: Bool { get }
    var customToken: String? { get }
}
