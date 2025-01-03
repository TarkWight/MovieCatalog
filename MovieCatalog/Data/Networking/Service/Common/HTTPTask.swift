//
//  HTTPTask.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

typealias Parameters = [String: Any]

enum HTTPTask {
    case request
    case requestBody(Data)
    case requestUrlParameters(Parameters)
}
