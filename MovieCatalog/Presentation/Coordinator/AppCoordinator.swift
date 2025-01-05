//
//  AppCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import UIKit

final class AppCoordinator {

    private let window: UIWindow
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        checkAuthorization()
    }

    private func checkAuthorization() {
        showAuthScene()

    }

    private func showAuthScene() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            showMainSceneHandler: { [weak self] in
                self?.showMainScene()
            }
        )
        authCoordinator.start()
    }

    private func showMainScene() {
        let mainCoordinator = MainCoordinator(showAuthSceneHandler: { [weak self] in
            self?.showAuthScene()
        })
        let mainTabBar = mainCoordinator.start()
        navigationController.setViewControllers([mainTabBar], animated: true)
    }
}
