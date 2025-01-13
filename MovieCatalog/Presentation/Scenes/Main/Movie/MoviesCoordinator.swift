//
//  MoviesCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit
import SwiftUI

@MainActor
protocol MoviesCoordinatorProtocol {
    func showMovieDetails(movieId: UUID)
}

final class MoviesCoordinator {
    private let sceneFactory: SceneFactory
    private let handleUnauthorized: () -> Void

    let navigationController: UINavigationController

    init(
        sceneFactory: SceneFactory,
        handleUnauthorized: @escaping () -> Void
    ) {
        self.sceneFactory = sceneFactory
        self.navigationController = UINavigationController()
        self.handleUnauthorized = handleUnauthorized
    }
   
}


extension MoviesCoordinator: MoviesCoordinatorProtocol {
    
    func showMovieDetails(movieId: UUID) {
        navigationController.pushViewController(sceneFactory.makeMovieDetailsView(movieId: movieId), animated: true)
    }
}
