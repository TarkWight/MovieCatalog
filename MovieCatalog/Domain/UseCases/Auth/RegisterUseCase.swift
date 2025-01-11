//
//  RegisterUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 09.01.2025.
//


import Foundation

final class RegisterUseCase {
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(_ user: UserRegister) async throws {
        try await authRepository.register(user: user)
    }
}
