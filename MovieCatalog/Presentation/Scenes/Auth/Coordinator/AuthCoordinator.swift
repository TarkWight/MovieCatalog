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
//    func didCompleteLogin()
}

@MainActor
final class AuthCoordinator {
    private let navigationController: UINavigationController
    private let sceneFactory: SceneFactory

    init(navigationController: UINavigationController, sceneFactory: SceneFactory) {
        self.navigationController = navigationController
        self.sceneFactory = sceneFactory
        showWelcome()
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    func showWelcome() {
        let welcomeVC = sceneFactory.makeWelcomeScene(coordinator: self)
        navigationController.setViewControllers([welcomeVC], animated: false)
    }

    func showLogin() {
        let loginVC = sceneFactory.makeLoginScene(coordinator: self)
        navigationController.pushViewController(loginVC, animated: true)
    }

    func showRegistration() {
        let personalInfo = UserInfoViewModel.default
        let registrationVC = sceneFactory.makeRegisterScene(personalInfo: personalInfo, coordinator: self)
        navigationController.pushViewController(registrationVC, animated: true)
    }

//    func didCompleteLogin() {
//        let appCoordinator = AppCoordinator(
//            window: UIApplication.shared.windows.first!,
//            sceneFactory: sceneFactory, networkService: networkService
//        )
//        appCoordinator.showMainScene()
//    }
}
