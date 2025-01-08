//
//  AuthCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import UIKit

@MainActor
protocol AuthCoordinatorProtocol: AnyObject {
    func showWelcome()
    func showLogin()
    func showRegistration()
}

@MainActor
final class AuthCoordinator {
    private(set) var navigationController: UINavigationController
    private let sceneFactory: SceneFactory

    init(navigationController: UINavigationController, sceneFactory: SceneFactory) {
        self.navigationController = navigationController
        self.sceneFactory = sceneFactory
    }

    func start() {
        showWelcome()
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    func showWelcome() {
        let welcomeVC = sceneFactory.makeWelcomeView(coordinator: self)
        navigationController.setViewControllers([welcomeVC], animated: true)
    }

    func showLogin() {
        let loginVC = sceneFactory.makeLoginView(coordinator: self)
        navigationController.setViewControllers([loginVC], animated: true)
    }

    func showRegistration() {
//        let registrationVC = sceneFactory.makeRegistrationView(coordinator: self)
//        navigationController.pushViewController(registrationVC, animated: true)
    }
}
