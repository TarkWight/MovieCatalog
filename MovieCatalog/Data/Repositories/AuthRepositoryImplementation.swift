//  AuthRepositoryImplementation.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import Foundation

final class AuthRepositoryImplementation {

    private let networkService: NetworkService
    private let keychainService: KeychainService

    init(networkService: NetworkService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }

    // MARK: - Private Methods
    private func fetchUserProfileAndSaveUserId() async throws {
        let profile: ProfileDTO = try await networkService.request(with: UserNetworkConfig.getProfile, useToken: true)
        try keychainService.saveUserId(profile.id)
    }
}

extension AuthRepositoryImplementation: AuthRepository {

    func logOut() async throws {
        let config = AuthNetworkConfig.logout
        try await networkService.request(with: config)
        try keychainService.deleteToken()
        try keychainService.deleteUserId()
        CoreDataManager.shared.clearDatabase()
        GlobalFavoriteTagsManager.shared.clearFavorites()
    }

    func logIn(credentials: LoginCredentials) async throws {
        let data = try networkService.encode(credentials)
        let config = AuthNetworkConfig.login(data)
        let tokenInfo: TokenInfo = try await networkService.request(with: config)
        print("\n\ntokenInfo is \(tokenInfo)")
        try keychainService.saveToken(tokenInfo.token)

        try await fetchUserProfileAndSaveUserId()
    }

    func register(user: UserRegister) async throws {
        let userDto = UserRegisterDTO(
            userName: user.userName,
            name: user.name,
            password: user.password,
            email: user.email,
            birthDate: user.birthDate,
            gender: user.gender == .female ? .female : .male
        )
        let data = try networkService.encode(userDto)
        let config = AuthNetworkConfig.register(data)
        
        let tokenInfo: TokenInfo = try await networkService.request(with: config)
        
        
        try keychainService.saveToken(tokenInfo.token)
        try await fetchUserProfileAndSaveUserId()
    }
}
