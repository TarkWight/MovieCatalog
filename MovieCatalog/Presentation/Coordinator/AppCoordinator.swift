//
//  AppCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import UIKit

@MainActor
final class AppCoordinator {

    // MARK: - Properties
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let sceneFactory: SceneFactory
    let networkService: NetworkService

    lazy var handleUnauthorized: () -> Void = { [weak self] in
        Task { @MainActor in
            self?.resetToAuthScene()
        }
    }

    private var mainCoordinator: MainCoordinator?

    // MARK: - Initializer
    init(window: UIWindow, sceneFactory: SceneFactory, networkService: NetworkService) {
        self.window = window
        self.navigationController = UINavigationController()
        self.sceneFactory = sceneFactory
        self.networkService = networkService

        configureNetworkCallbacks()
        configureRootViewController()
    }

    // MARK: - Private Methods
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
                self?.resetToAuthScene()
            }
        }
    }

    private func checkAuthorization() {
        do {
            let _ = try networkService.keychainService.retrieveToken()
            showMainScene()
        } catch {
            resetToAuthScene()
        }
    }

    // MARK: - Public Methods
    func showAuthScene() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            sceneFactory: sceneFactory
        )
        authCoordinator.showWelcome()
    }

    func showMainScene() {
        let mainCoordinator = MainCoordinator(
            sceneFactory: sceneFactory,
            navigationController: navigationController,
            handleUnauthorized: handleUnauthorized
        )
        self.mainCoordinator = mainCoordinator

        let mainViewController = mainCoordinator.start()
        navigationController.setViewControllers([mainViewController], animated: true)
    }

    func resetToAuthScene() {
        navigationController.viewControllers = []
        showAuthScene()
    }
}
