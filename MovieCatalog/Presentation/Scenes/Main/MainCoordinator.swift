//
//  MainCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//

import UIKit


final class MainCoordinator {
    // MARK: - Properties
    private let sceneFactory: SceneFactory
    private let navigationController: UINavigationController
    private let handleUnauthorized: () -> Void

    private(set) var mainViewController: MainCoordinatorViewController?

    // MARK: - Initializer
    init(
        sceneFactory: SceneFactory,
        navigationController: UINavigationController,
        handleUnauthorized: @escaping () -> Void
    ) {
        self.sceneFactory = sceneFactory
        self.navigationController = navigationController
        self.handleUnauthorized = handleUnauthorized
    }

    // MARK: - Public Methods
    func start() -> MainCoordinatorViewController {
        let feedCoordinator = FeedCoordinator(
            factory: sceneFactory,
            feedFactory: sceneFactory,
            handleUnauthorized: handleUnauthorized
        )
        let moviesCoordinator = MoviesCoordinator(
            sceneFactory: sceneFactory,
            handleUnauthorized: handleUnauthorized
        )
        let favoritesCoordinator = FavoritesCoordinator(
            sceneFactory: sceneFactory,
            handleUnauthorized: handleUnauthorized
        )
        let profileCoordinator = ProfileCoordinator(
            factory: sceneFactory,
            handleUnauthorized: handleUnauthorized
        )

        let mainViewController = MainCoordinatorViewController(
            factory: sceneFactory,
            feedCoordinator: feedCoordinator,
            moviesCoordinator: moviesCoordinator,
            favoritesCoordinator: favoritesCoordinator,
            profileCoordinator: profileCoordinator
        )

        self.mainViewController = mainViewController
        return mainViewController
    }
}
