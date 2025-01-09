//
//  AppFactory.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import Foundation

final class AppFactory {
    private lazy var keychainService = KeychainService()
    private lazy var networkService = NetworkService(keychainService: keychainService)
    private lazy var authRepository = AuthRepositoryImplementation(networkService: networkService, keychainService: keychainService)


}

extension AppFactory {

    func makeValidateEmailUseCase() -> ValidateEmailUseCase {
        ValidateEmailUseCase()
    }

    func makeValidateUsernameUseCase() -> ValidateUsernameUseCase {
        ValidateUsernameUseCase()
    }

    func makeValidatePasswordUseCase() -> ValidatePasswordUseCase {
        ValidatePasswordUseCase()
    }
}

extension AppFactory {

    func makeLoginUseCase() -> LoginUseCase {
        return LoginUseCase(authRepository: authRepository)
    }

    func makeRegisterUseCase() -> RegisterUseCase {
        return RegisterUseCase(authRepository: authRepository)
    }

    
}
