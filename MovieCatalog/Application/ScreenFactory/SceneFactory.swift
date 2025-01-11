//
//  SceneFactory.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import UIKit
import SwiftUI

final class SceneFactory: AuthCoordinatorFactory,
                          FeedCoordinatorFactory,
                          MoviesCoordinatorFactory,
                          FavoritesCoordinatorFactory,
                          ProfileCoordinatorFactory {
    private let appFactory: AppFactory

    init(appFactory: AppFactory) {
        self.appFactory = appFactory
    }
}

// MARK: - LoginSceneFactory
extension SceneFactory: LoginSceneFactory {
    func makeLoginScene(coordinator: AuthCoordinatorProtocol) -> LoginViewController {
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            loginUseCase: appFactory.makeLoginUseCase()
        )
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - WelcomeSceneFactory
extension SceneFactory: WelcomeSceneFactory {
    func makeWelcomeScene(coordinator: AuthCoordinatorProtocol) -> WelcomeViewController {
        let viewModel = WelcomeViewModel(coordinator: coordinator)
        let viewController = WelcomeViewController(viewModel: viewModel)
        return viewController
    }
}


// MARK: - RegisterFactory
extension SceneFactory: RegisterSceneFactory {
    func makeRegisterScene(personalInfo: UserInfoViewModel, coordinator: AuthCoordinatorProtocol) -> RegisterViewController {
        let viewModel = RegisterViewModel(
            personalInfo: personalInfo,
            coordinator: coordinator,
            registerUseCase: appFactory.makeRegisterUseCase(),
            validateUsernameUseCase: appFactory.makeValidateUsernameUseCase(),
            validateEmailUseCase: appFactory.makeValidateEmailUseCase(),
            validatePasswordUseCase: appFactory.makeValidatePasswordUseCase()            
        )
        let viewController = RegisterViewController(viewModel: viewModel)
        return viewController
    }
}


// MARK: - FeedSceneFactory
extension SceneFactory: FeedSceneFactory {
    func makeFeedScene(coordinator: FeedCoordinatorProtocol) -> FeedViewController {
        let viewModel = FeedViewModel(
            coordinator: coordinator,
            fetchFeedUseCase: appFactory.makeFetchMovieListUseCase(),
            fetchMovieDetailsUseCase: appFactory.makeFetchFavoriteMoviesUseCase()
        )
        return FeedViewController(viewModel: viewModel)
    }
}

// MARK: - MoviesSceneFactory
extension SceneFactory: MoviesSceneFactory {
    func makeMoviesScene(coordinator: MoviesCoordinatorProtocol) -> MoviesViewController {
        let viewModel = MoviesViewModel(
            coordinator: coordinator,
            fetchMovieListUseCase: appFactory.makeFetchMovieListUseCase()
        )
        return MoviesViewController(viewModel: viewModel)
    }
}

// MARK: - FavoritesSceneFactory
extension SceneFactory: FavoritesViewFactory {
    func makeFavoritesView(coordinator: FavoritesCoordinatorProtocol) -> FavoritesScreen {
        let viewModel = FavoritesViewModel(
            coordinator: coordinator,
            fetchFavoriteMoviesUseCase: appFactory.makeFetchFavoriteMoviesUseCase()
        )
        return FavoritesScreen(factory: self, viewModel: viewModel)
    }
}

// MARK: - ProfileSceneFactory
extension SceneFactory: ProfileSceneFactory {
    func makeProfileScene(coordinator: ProfileCoordinatorProtocol) -> ProfileViewController {
        let viewModel = ProfileViewModel(
            coordinator: coordinator,
            fetchProfileUseCase: appFactory.makeFetchProfileUseCase(),
            updateProfileUseCase: appFactory.makeUpdateProfileUseCase(),
            logoutUseCase: appFactory.makeLogoutUseCase()
        )
        return ProfileViewController(viewModel: viewModel)
    }
}

// MARK: - MovieDetailsSceneFactory
extension SceneFactory: MovieDetailsViewFactory {
    func makeMovieDetailsView(movieId: UUID) -> UIViewController {
        let view = MovieDetailsScreen(movieId: movieId)
        return UIHostingController(rootView: view)
    }
}


