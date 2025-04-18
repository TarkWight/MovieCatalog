//
//  FetchProfileUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class FetchProfileUseCase {

    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    @discardableResult
    func execute() async throws -> Profile {
        return try await profileRepository.getProfile()
    }
}
