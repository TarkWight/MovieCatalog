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

    lazy var handleUnauthorized: () -> Void = { [unowned self] in
        Task { @MainActor in
            print("App.resetToAuthScene()")
            self.resetToAuthScene()
        }
    }

    lazy var completeAuthorization: () -> Void = { [unowned self] in
        Task { @MainActor in
            print("App.completeAuthorization()")
            self.mainStage()
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

        Task { @MainActor in
            checkAuthorization()
        }
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
        Task { @MainActor in
            do {
                let _ = try networkService.keychainService.retrieveToken()
                showMainScene()
            } catch {
                resetToAuthScene()
            }
        }
    }

    // MARK: - Public Methods
    func showAuthScene() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            sceneFactory: sceneFactory, completeAuthorization: completeAuthorization
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
    
    func mainStage() {
        navigationController.viewControllers = []
        showMainScene()
    }

}
