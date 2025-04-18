//
//  FriendCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//


import UIKit

final class FriendCoordinator: FriendCoordinatorProtocol {
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let factory: SceneFactory

    // MARK: - Initializer
    init(navigationController: UINavigationController, factory: SceneFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    // MARK: - Navigation
  
    func backToProfile() {
        navigationController.popViewController(animated: true)
    }
}
