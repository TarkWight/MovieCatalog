//
//  FavoritesCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit
import SwiftUI

@MainActor
protocol FavoritesCoordinatorProtocol {
    func start() -> UINavigationController
    func showMovieDetails(movieId: UUID)
}

final class FavoritesCoordinator {
    private let sceneFactory: SceneFactory
    let navigationController: UINavigationController

    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
        self.navigationController = UINavigationController()
    }

    @MainActor func showMovieDetails(movieId: UUID) {
        navigationController.pushViewController(sceneFactory.makeMovieDetailsView(movieId: movieId), animated: true)
    }
}

