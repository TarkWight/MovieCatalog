//
//  TokenInterceptor.swift
//  MovieCatalog
//
//  Created by Tark Wight on 22.12.2024.
//

import Foundation

final class TokenInterceptor {

    private let keychainService: KeychainService

    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }

    func intercept(request: inout URLRequest) throws {
        do {
            let token = try keychainService.retrieveToken()
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } catch let error {
            throw error
        }
    }
}
