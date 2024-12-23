//
//  KeychainError.swift
//  MovieCatalog
//
//  Created by Tark Wight on 22.12.2024.
//

import Foundation

enum KeychainError: LocalizedError {
    case invalidData
    case itemNotFound
    case duplicateItem
    case incorrectAttributeForClass
    case unexpectedStatus(OSStatus)

    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Invalid data"
        case .itemNotFound:
            return "Item not found"
        case .duplicateItem:
            return "Duplicate Item"
        case .incorrectAttributeForClass:
            return "Incorrect Attribute for Class"
        case .unexpectedStatus(let status):
            return "Unexpected error - \(status)"
        }
    }
}
