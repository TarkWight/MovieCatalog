//
//  ProfileRemoteDataSource.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class ProfileRemoteDataSource {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension ProfileRemoteDataSource {

    func fetchProfile() async throws -> ProfileDTO {
        let config = UserNetworkConfig.getProfile
        return try await networkService.request(with: config, useToken: true)
    }

    func updateProfile(profile: ProfileDTO) async throws {
        let data = try networkService.encode(profile)
        let config = UserNetworkConfig.updateProfile(data)

        try await networkService.request(with: config, useToken: true)
    }
}
