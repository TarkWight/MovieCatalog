//
//  SceneFactoryProtocols.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import UIKit

@MainActor
protocol WelcomeSceneFactory {
    func makeWelcomeScene(coordinator: AuthCoordinatorProtocol) -> WelcomeViewController
}

@MainActor
protocol LoginSceneFactory {
    func makeLoginScene(coordinator: AuthCoordinatorProtocol) -> LoginViewController
}

@MainActor
protocol RegisterSceneFactory {
    func makeRegisterScene(personalInfo: UserInfoViewModel,
                          coordinator: AuthCoordinatorProtocol) -> RegisterViewController
}


@MainActor
protocol FeedSceneFactory {
    func makeFeedScene(coordinator: FeedCoordinatorProtocol) -> FeedViewController
}

@MainActor
protocol MoviesSceneFactory {
    func makeMoviesScene(coordinator: MoviesCoordinatorProtocol) -> MoviesViewController
}

@MainActor
protocol FavoritesViewFactory {
    func makeFavoritesView(coordinator: FavoritesCoordinatorProtocol) -> FavoritesScreen
}

@MainActor
protocol ProfileSceneFactory {
    func makeProfileScene(coordinator: ProfileCoordinatorProtocol) -> ProfileViewController
}

@MainActor
protocol MovieDetailsViewFactory {
    func makeMovieDetailsView(movieId: UUID) -> UIViewController
}
