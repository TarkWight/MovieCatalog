//
//  UpdateProfileUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class UpdateProfileUseCase {

    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(profile: Profile) async throws {
        try await profileRepository.updateProfile(profile)
    }
}
