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
    let navigationController = UINavigationController()
    private let movieDetailsFactory: MovieDetailsViewFactory

    init(factory: MovieDetailsViewFactory) {
        self.movieDetailsFactory = factory
    }
}

extension FeedCoordinator: FeedCoordinatorProtocol {
    func showMovieDetails(movieId: UUID) {
        let movieDetailsViewController = movieDetailsFactory.makeMovieDetailsView(movieId: movieId)
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
}
