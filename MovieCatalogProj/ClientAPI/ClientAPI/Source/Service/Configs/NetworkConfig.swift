//
//  NetworkConfig.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

protocol NetworkConfig {
    var path: String { get }
    var endPoint: String { get }
    
    var task: HTTPTask { get }
    var method: HTTPMethod { get }
}
