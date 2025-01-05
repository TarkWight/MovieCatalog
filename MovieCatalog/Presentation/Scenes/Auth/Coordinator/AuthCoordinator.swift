//
//  AuthCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import UIKit

protocol AuthCoordinatorProtocol: AnyObject {
    func showLogin()
    func showMainScene()
    func showRegistration()
}

final class AuthCoordinator: Coordinator {

    private(set) var navigationController: UINavigationController
    private let showMainSceneHandler: () -> Void

    init(navigationController: UINavigationController, showMainSceneHandler: @escaping () -> Void) {
        self.navigationController = navigationController
        self.showMainSceneHandler = showMainSceneHandler
    }

    func start() {
        showLogin()
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {

    func showLogin() {
            Task { @MainActor in
                let viewModel = WelcomeViewModel(coordinator: self)
                let loginVC = WelcomeViewController(viewModel: viewModel)
                navigationController.setViewControllers([loginVC], animated: true)
            }
        }

    func showMainScene() {
        showMainSceneHandler()
    }

    func showRegistration() {
        let personalInfoVC = RegistrationViewController()
        navigationController.pushViewController(personalInfoVC, animated: true)
    }

}
