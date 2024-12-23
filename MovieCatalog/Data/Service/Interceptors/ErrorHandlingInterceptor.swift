//
//  ErrorHandlingInterceptor.swift
//  MovieCatalog
//
//  Created by Tark Wight on 22.12.2024.
//

import Foundation

final class ErrorHandlingInterceptor: ErrorInterceptor {
    private let keychainService: KeychainService

    init(keychainService: KeychainService) {
        self.keychainService = keychainService
    }

    func intercept(error: Error) throws -> Error {
        if let networkError = error as? NetworkError {
            if let httpError = networkError as? HTTPStatusCode, httpError == .unauthorized {
                try keychainService.deleteToken()
            }
        }
        throw error
    }
}
