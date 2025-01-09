//
//  SceneFactoryProtocols.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import UIKit

@MainActor
protocol LoginViewFactory {
    func makeLoginView(coordinator: AuthCoordinatorProtocol) -> LoginViewController
}

@MainActor
protocol WelcomeViewFactory {
    func makeWelcomeView(coordinator: AuthCoordinatorProtocol) -> WelcomeViewController
}

@MainActor
protocol RegisterViewFactory {
    func makeRegisterView(personalInfo: UserInfoViewModel,
                          coordinator: AuthCoordinatorProtocol) -> RegisterViewController
}
