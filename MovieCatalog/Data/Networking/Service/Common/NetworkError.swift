//
//  NetworkError.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case missingURL
    case noConnect
    case invalidData
    case requestFailed
    case encodingError
    case decodingError
    case invalidResponse

    var errorDescription: String? {
            switch self {
            case .missingURL:
                return NSLocalizedString(LocalizedKey.ErrorMessage.Network.missingURL, comment: "Missing URL error")
            case .noConnect:
                return NSLocalizedString(LocalizedKey.ErrorMessage.Network.noConnect, comment: "No network connection error")
            case .invalidResponse:
                return NSLocalizedString(LocalizedKey.ErrorMessage.Network.invalidResponse, comment: "Invalid response error")
            case .invalidData:
                return NSLocalizedString(LocalizedKey.ErrorMessage.Network.invalidData, comment: "Invalid data error")
            case .decodingError:
                return NSLocalizedString(LocalizedKey.ErrorMessage.Network.decodingError, comment: "Decoding error")
            case .encodingError:
                return NSLocalizedString(LocalizedKey.ErrorMessage.Network.encodingError, comment: "Encoding error")
            case .requestFailed:
                return NSLocalizedString(LocalizedKey.ErrorMessage.Network.requestFailed, comment: "Request failed error")
            }
        }
}
