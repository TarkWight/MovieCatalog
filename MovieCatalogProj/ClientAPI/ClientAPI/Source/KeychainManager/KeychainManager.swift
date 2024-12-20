//
//  KeychainManager.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation
import Security

import Foundation
import Security

protocol KeychainServiceProtocol {
    func saveToken(_ token: String) throws
    func retrieveToken() throws -> String
    func updateToken(_ newToken: String) throws
    func deleteToken() throws
}

final class KeychainService: KeychainServiceProtocol {

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

    private enum Key: String {
        case accessToken
    }

    func saveToken(_ token: String) throws {
        guard let data = token.data(using: .utf8) else {
            throw KeychainError.invalidData
        }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: data,
            kSecAttrAccount: Key.accessToken.rawValue
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        guard status == errSecSuccess else {
            throw convertError(status)
        }
    }

    func retrieveToken() throws -> String {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Key.accessToken.rawValue,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue as Any
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            throw convertError(status)
        }

        guard let data = result as? Data else {
            throw KeychainError.invalidData
        }

        return String(decoding: data, as: UTF8.self)
    }

    func updateToken(_ newToken: String) throws {
        guard let data = newToken.data(using: .utf8) else {
            throw KeychainError.invalidData
        }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Key.accessToken.rawValue
        ] as CFDictionary
        let attributesToUpdate = [kSecValueData: data] as CFDictionary

        let status = SecItemUpdate(query, attributesToUpdate)

        guard status == errSecSuccess else {
            throw convertError(status)
        }
    }

    func deleteToken() throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Key.accessToken.rawValue
        ] as CFDictionary

        let status = SecItemDelete(query)

        guard status == errSecSuccess else {
            throw convertError(status)
        }
    }

    private func convertError(_ status: OSStatus) -> KeychainError {
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
