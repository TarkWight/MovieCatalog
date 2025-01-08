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

    // Auth
    func makeLoginUseCase() -> LoginUseCase {
        return LoginUseCase(authRepository: authRepository)
    }

//    func makeRegisterUserUseCase() -> RegisterUserUseCase {
//        return RegisterUserUseCase(authRepository: authRepository)
//    }

//    func makeLogoutUseCase() -> LogoutUseCase {
//        return LogoutUseCase(authRepository: authRepository)
//    }
}
