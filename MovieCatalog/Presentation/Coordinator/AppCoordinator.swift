//
//  AppCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import UIKit

@MainActor
final class AppCoordinator {

    private let window: UIWindow
    private let navigationController: UINavigationController
    private let sceneFactory: SceneFactory
    let networkService: NetworkService

    init(window: UIWindow, sceneFactory: SceneFactory, networkService: NetworkService) {
        self.window = window
        self.navigationController = UINavigationController()
        self.sceneFactory = sceneFactory
        self.networkService = networkService

        configureNetworkCallbacks()
        configureRootViewController()
    }

    private func configureRootViewController() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        checkAuthorization()
    }

    private func configureNetworkCallbacks() {
        networkService.onLoginSuccess = { [weak self] in
            Task { @MainActor in
                self?.showMainScene()
            }
        }

        networkService.onUnauthorized = { [weak self] in
            Task { @MainActor in
                self?.showAuthScene()
            }
        }
    }

    private func checkAuthorization() {
        do {
            let _ = try networkService.keychainService.retrieveToken()
            showMainScene()
        } catch {
            showAuthScene()
        }
    }

    func showAuthScene() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            sceneFactory: sceneFactory
        )
        authCoordinator.showWelcome()
    }

    func showMainScene() {
        let mainCoordinatorViewController = MainCoordinatorViewController(factory: sceneFactory)
        navigationController.setViewControllers([mainCoordinatorViewController], animated: true)
    }
}
