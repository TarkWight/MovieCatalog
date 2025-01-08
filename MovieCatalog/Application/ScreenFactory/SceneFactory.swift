//
//  SceneFactory.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import UIKit

final class SceneFactory: AuthCoordinatorFactory {
    private let appFactory: AppFactory

    init(appFactory: AppFactory) {
        self.appFactory = appFactory
    }
}

// MARK: - LoginViewFactory
extension SceneFactory: LoginViewFactory {
    func makeLoginView(coordinator: AuthCoordinatorProtocol) -> LoginViewController {
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            loginUseCase: appFactory.makeLoginUseCase()
        )
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }
}

// MARK: - WelcomeViewFactory
extension SceneFactory: WelcomeViewFactory {
    func makeWelcomeView(coordinator: AuthCoordinatorProtocol) -> WelcomeViewController {
        let viewModel = WelcomeViewModel(coordinator: coordinator)
        let viewController = WelcomeViewController(viewModel: viewModel)
        return viewController
    }
}
