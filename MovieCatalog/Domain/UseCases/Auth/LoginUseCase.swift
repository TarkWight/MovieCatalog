//
//  LoginUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 20.12.2024.
//

import Foundation

final class LoginUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(username: String, password: String) async throws {
        let credentials = LoginCredentials(username: username, password: password)
        print("In LoginUseCase username: \(credentials.username)\npassword: \(credentials.password)")
        do {
                try await authRepository.logIn(credentials: credentials)
                print("Login successful in LoginUseCase")
            } catch {
                print("Error in LoginUseCase: \(error)")
                throw error
            }
        
    }
}
