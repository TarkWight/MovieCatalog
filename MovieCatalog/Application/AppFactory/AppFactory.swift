//
//  AppFactory.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import Foundation

final class AppFactory {
    // MARK: - Services
    private lazy var keychainService = KeychainService()
    private lazy var networkService = NetworkService(keychainService: keychainService)

    // MARK: - Repositories
    private lazy var authRepository = AuthRepositoryImplementation(networkService: networkService, keychainService: keychainService)
    private lazy var movieRepository = MovieRepositoryImplementation(
        localDataSource: MovieLocalDataSource(),
        remoteDataSource: MovieRemoteDataSource(networkService: networkService)
    )
    private lazy var profileRepository = ProfileRepositoryImplementation(
        localDataSource: ProfileLocalDataSource(),
        remoteDataSource: ProfileRemoteDataSource(networkService: networkService)
    )
    private lazy var reviewRepository = ReviewRepositoryImplementation(networkService: networkService)
    private lazy var friendRepository = FriendRepositoryImplementation(
        localDataSource: FriendLocalDataSource()
    )
}

// MARK: - Validation Use Cases
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

// MARK: - Auth Use Cases
extension AppFactory {
    func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(authRepository: authRepository)
    }

    func makeRegisterUseCase() -> RegisterUseCase {
        RegisterUseCase(authRepository: authRepository)
    }

    func makeLogoutUseCase() -> LogoutUseCase {
        LogoutUseCase(authRepository: authRepository, movieRepository: movieRepository, profileRepository: profileRepository)
    }
}


// MARK: - Favorites Use Cases
extension AppFactory {
    func makeFetchFavoriteMoviesUseCase() -> FetchFavoriteMoviesUseCase {
        FetchFavoriteMoviesUseCase(movieRepository: movieRepository)
    }

    func makeAddFavoriteMovieUseCase() -> AddFavoriteMovieUseCase {
        AddFavoriteMovieUseCase(movieRepository: movieRepository)
    }

    func makeDeleteFavoriteMovieUseCase() -> DeleteFavoriteMovieUseCase {
        DeleteFavoriteMovieUseCase(movieRepository: movieRepository)
    }
}

// MARK: - Movie Use Cases
extension AppFactory {
    func makeFetchMovieListUseCase() -> FetchMovieListUseCase {
        FetchMovieListUseCase(movieRepository: movieRepository)
    }
}

// MARK: - Profile Use Cases
extension AppFactory {
    func makeFetchProfileUseCase() -> FetchProfileUseCase {
        FetchProfileUseCase(profileRepository: profileRepository)
    }

    func makeUpdateProfileUseCase() -> UpdateProfileUseCase {
        UpdateProfileUseCase(profileRepository: profileRepository)
    }
}


// MARK: - Friend Use Cases
extension AppFactory {
    func makeFetchFriendsUseCase() -> FetchFriendsUseCase {
        FetchFriendsUseCase(friendRepository: friendRepository)
    }

    func makeRemoveFriendUseCase() -> RemoveFriendUseCase {
        RemoveFriendUseCase(friendRepository: friendRepository)
    }
}

// MARK: - Movie Ignore List Use Cases
extension AppFactory {
    func makeAddMovieToIgnoreListUseCase() -> AddMovieToIgnoreListUseCase {
        AddMovieToIgnoreListUseCase(blacklistManager: BlacklistManager())
    }
}
