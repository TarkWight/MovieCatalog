//
//  KeychainManager.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation
import Security

public class KeychainManager {
    
    public static let shared = KeychainManager()
    private let tokenKey = "BearerTokenKey"

    public func saveToken(_ token: String) -> Bool {
        guard let tokenData = token.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: tokenData
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    public func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    public func deleteToken() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
