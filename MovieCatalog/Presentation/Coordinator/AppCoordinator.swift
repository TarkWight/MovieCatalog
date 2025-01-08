//  AppCoordinator.swift
//  MovieCatalog
//  Created by Tark Wight on 04.01.2025.

import UIKit

protocol AppCoordinatorDelegate: AnyObject {
    func didTransitionToAuthScene()
    func didTransitionToLoading()
}

@MainActor
final class AppCoordinator {

    weak var delegate: AppCoordinatorDelegate?

    private let window: UIWindow
    let navigationController: UINavigationController
    private let sceneFactory: SceneFactory

    init(window: UIWindow, sceneFactory: SceneFactory) {
        self.window = window
        self.navigationController = UINavigationController()
        self.sceneFactory = sceneFactory
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        print("Переход к проверке авторизации")
        checkAuthorization()
    }

    private func checkAuthorization() {
        print("Переход к авторизации")
        delegate?.didTransitionToLoading() 
        showAuthScene()
    }

    func showAuthScene() {
        let authCoordinator = AuthCoordinator(
            navigationController: navigationController,
            sceneFactory: sceneFactory
        )
        authCoordinator.start()

        // После того как сцена авторизации показана, делаем уведомление через делегат.
        delegate?.didTransitionToAuthScene()
    }

    func showMainScene() {
        let mainCoordinator = MainCoordinator()
        let mainTabBar = mainCoordinator.start()
        navigationController.setViewControllers([mainTabBar], animated: true)
    }
}
