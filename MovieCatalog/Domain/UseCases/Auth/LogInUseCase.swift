//
//  LogInUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 28.12.2024.
//

import Foundation

final class LogInUseCase {
    private let logInRepository: AuthRepository
    
    init(logInRepository: AuthRepository) {
        self.logInRepository
    }
    
    func execute(_ user: UserLogIn) async throws {
        try await logInRepository.logIn(user: user)
    }
    
}
