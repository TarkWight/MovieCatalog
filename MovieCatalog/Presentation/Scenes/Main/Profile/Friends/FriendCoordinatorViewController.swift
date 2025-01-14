//
//  FriendCoordinatorViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//


import UIKit

final class FriendCoordinatorViewController {
    // MARK: - Properties
    private let coordinator: FriendCoordinatorProtocol
    private let factory: SceneFactory

    // MARK: - Initializer
    init(coordinator: FriendCoordinatorProtocol, factory: SceneFactory) {
        self.coordinator = coordinator
        self.factory = factory
    }

//    // MARK: - Entry Point
//    func startFriendsFlow() -> UIViewController {
//        let friendListViewController = factory.makeFriendScene(coordinator: coordinator)
//        return UINavigationController(rootViewController: friendListViewController)
//    }
}
