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
    lazy var feedViewController: FeedCoordinatorViewController = {
        FeedCoordinatorViewController(
            coordinator: self,
            feedFactory: feedFactory
        )
    }()
    private let movieDetailsFactory: MovieDetailsViewFactory
    private let feedFactory: FeedSceneFactory
    private let handleUnauthorized: () -> Void

    // MARK: - Initializer
    init(
        factory: MovieDetailsViewFactory,
        feedFactory: FeedSceneFactory,
        handleUnauthorized: @escaping () -> Void
    ) {
        self.movieDetailsFactory = factory
        self.feedFactory = feedFactory
        self.handleUnauthorized = handleUnauthorized
    }
}

// MARK: - FeedCoordinatorProtocol
extension FeedCoordinator: FeedCoordinatorProtocol {
    func showMovieDetails(movieId: UUID) {
        let movieDetailsViewController = movieDetailsFactory.makeMovieDetailsView(movieId: movieId)
        feedViewController.present(movieDetailsViewController, animated: true)
    }
}
