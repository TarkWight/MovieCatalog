//
//  FeedCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import UIKit

@MainActor
protocol FeedCoordinatorProtocol {
    func showMovieDetails(movieId: UUID)
}

final class FeedCoordinator {
    // MARK: - Properties
    let navigationController: UINavigationController
    private let movieDetailsFactory: MovieDetailsViewFactory
    private let feedFactory: FeedSceneFactory

    // MARK: - Initializer
    init(factory: MovieDetailsViewFactory, feedFactory: FeedSceneFactory) {
        self.movieDetailsFactory = factory
        self.feedFactory = feedFactory
        self.navigationController = UINavigationController()
        setupFeedScene()
    }

    // MARK: - Private Setup
    private func setupFeedScene() {
        let feedCoordinatorViewController = FeedCoordinatorViewController(
            coordinator: self,
            feedFactory: feedFactory
        )
        navigationController.viewControllers = [feedCoordinatorViewController]
    }
}

// MARK: - FeedCoordinatorProtocol
extension FeedCoordinator: FeedCoordinatorProtocol {
    func showMovieDetails(movieId: UUID) {
        let movieDetailsViewController = movieDetailsFactory.makeMovieDetailsView(movieId: movieId)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
