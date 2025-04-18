//
//  MoviesCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

@MainActor
protocol MoviesCoordinatorProtocol {
    func showMovieDetails(movieId: UUID)
    func unauthorized()
}

final class MoviesCoordinator {
    // MARK: - Properties
    lazy var moviesViewController: MoviesCoordinatorViewController = {
        MoviesCoordinatorViewController(
            coordinator: self,
            moviesFactory: factory
        )
    }()
    private let handleUnauthorized: () -> Void
    private let factory: SceneFactory

    // MARK: - Initializer
    init(
        factory: SceneFactory,
        handleUnauthorized: @escaping () -> Void
    ) {
        self.factory = factory
        self.handleUnauthorized = handleUnauthorized
    }
}

// MARK: - MoviesCoordinatorProtocol
extension MoviesCoordinator: MoviesCoordinatorProtocol {
    func showMovieDetails(movieId: UUID) {
        let detailsViewController = factory.makeMovieDetailsView(movieId: movieId)
        moviesViewController.present(detailsViewController, animated: true)
    }

    func unauthorized() {
        handleUnauthorized()
    }
}
