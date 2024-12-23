//
//  AuthUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import Foundation


protocol AuthUseCaseProtocol {
    func login(credentials: LoginCredentials) async throws -> Bool
    func register(body: UserRegisterModel) async throws -> Bool
    func logout() async throws -> Bool
}

final class AuthUseCase: AuthUseCaseProtocol {
    
    // MARK: - Login
    func login(credentials: LoginCredentials) async throws -> Bool {
        return try await AuthAPI().login(body: credentials)
    }
    
    // MARK: - Register
    func register(body: UserRegisterModel) async throws -> Bool {
        return try await AuthAPI().register(body: body)
    }
    
    // MARK: - Logout
    func logout() async throws -> Bool {
        return try await AuthAPI().logout()
    }
}
