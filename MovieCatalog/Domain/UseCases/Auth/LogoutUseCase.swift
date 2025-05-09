//
//  LogoutUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class LogoutUseCase {

    private let authRepository: AuthRepository
    private let movieRepository: MovieRepository
    private let profileRepository: ProfileRepository

    init(
        authRepository: AuthRepository,
        movieRepository: MovieRepository,
        profileRepository: ProfileRepository
    ) {
        self.authRepository = authRepository
        self.movieRepository = movieRepository
        self.profileRepository = profileRepository
    }

    func execute() async throws {
        try await movieRepository.deleteAllMovies()
        try await authRepository.logOut()
        await profileRepository.deleteProfile()
    }
}