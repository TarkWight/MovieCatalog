//
//  KeychainService.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation
import Security

final class KeychainService {

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

    fileprivate enum Key: String {
        case accessToken
        case userId
    }
}

// MARK: - Token Management
extension KeychainService {
    
    func saveToken(_ token: String) throws {
        try save(value: token, for: .accessToken)
    }

    func retrieveToken() throws -> String {
        return try retrieveValue(for: .accessToken)
    }
    
    func updateToken(_ newToken: String) throws {
        try update(value: newToken, for: .accessToken)
    }

    func deleteToken() throws {
        try deleteValue(for: .accessToken)
    }
}

// MARK: - User ID Management
extension KeychainService {

    func saveUserId(_ userId: UUID) throws {
        try save(value: userId.uuidString, for: .userId)
    }

    func retrieveUserId() async throws -> UUID {
        let userIdString = try retrieveValue(for: .userId)
        guard let userId = UUID(uuidString: userIdString) else {
            throw KeychainError.invalidData
        }
        return userId
    }
    
    func updateUserId(_ newUserId: UUID) throws {
        try update(value: newUserId.uuidString, for: .userId)
    }

    func deleteUserId() throws {
        try deleteValue(for: .userId)
    }
}

// MARK: - Private Keychain Methods
private extension KeychainService {

    func save(value: String, for key: Key) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.invalidData
        }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ] as CFDictionary

        let attributesToUpdate = [kSecValueData: data] as CFDictionary

        let status = SecItemUpdate(query, attributesToUpdate)

        if status == errSecItemNotFound {
            let addQuery = [
                kSecClass: kSecClassGenericPassword,
                kSecValueData: data,
                kSecAttrAccount: key.rawValue
            ] as CFDictionary

            let addStatus = SecItemAdd(addQuery, nil)

            guard addStatus == errSecSuccess else {
                throw convertError(addStatus)
            }
        } else if status != errSecSuccess {
            throw convertError(status)
        }
    }
    func retrieveValue(for key: Key) throws -> String {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue as Any
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            throw convertError(status)
        }

        guard let data = result as? Data, let value = String(data: data, encoding: .utf8) else {
            throw KeychainError.invalidData
        }

        return value
    }

    func update(value: String, for key: Key) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.invalidData
        }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ] as CFDictionary

        let attributesToUpdate = [kSecValueData: data] as CFDictionary

        let status = SecItemUpdate(query, attributesToUpdate)

        guard status == errSecSuccess else {
            throw convertError(status)
        }
    }

    func deleteValue(for key: Key) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ] as CFDictionary

        let status = SecItemDelete(query)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw convertError(status)
        }
    }

    func convertError(_ status: OSStatus) -> KeychainError {
        switch status {
        case errSecItemNotFound:
            return .itemNotFound
        case errSecDataTooLarge:
            return .invalidData
        case errSecDuplicateItem:
            return .duplicateItem
        default:
            return .unexpectedStatus(status)
        }
    }
}
