//
//  LocalizedKey.swift
//  ClientAPI
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

enum LocalizedKey {
    
    enum ErrorMessage {
        static let error = NSLocalizedString("Error", comment: "")
        
        enum Network {
            static let missingURL = "MissingURL"
            static let noConnect = "NoConnect"
            static let invalidResponse = "InvalidResponse"
            static let invalidData = "InvalidData"
            static let decodingError = "DecodingError"
            static let encodingError = "EncodingError"
            static let requestFailed = "RequestFailed"
            static let unauthorized = "Unauthorized"
        }
    }
}
