//
//  AppRouter.swift
//  MovieCatalog
//
//  Created by Tark Wight on 27.10.2024.
//

import UIKit
import ClientAPI

protocol RouterProtocol: AnyObject {
    func showWelcomeScreen()
    func showSignInScreen()
    func showSignUpScreen()
    func showFeedScreen()
    // TODO: Остальные методы
}

final class AppRouter: RouterProtocol {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        if isUserAuthenticated() {
            showFeedScreen()
        } else {
            showWelcomeScreen()
        }
    }

    private func isUserAuthenticated() -> Bool {
        return KeychainManager.shared.getToken() != nil
    }

    func showWelcomeScreen() {
        let welcomeVC = WelcomeModule.createModule(router: self)
        window.rootViewController = UINavigationController(rootViewController: welcomeVC)
        window.makeKeyAndVisible()
    }

    func showFeedScreen() {
        KeychainManager.shared.deleteToken()
//        let feedVC = FeedModule.createModule(router: self)
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [UINavigationController(rootViewController: feedVC)]
//        
//        window.rootViewController = tabBarController
//        window.makeKeyAndVisible()
    }

    func showSignInScreen() {
        let signInVC = SignInModule.createModule(router: self)
        currentNavigationController?.pushViewController(signInVC, animated: true)
    }

    func showSignUpScreen() {
//        let signUpVC = SignUpModule.createModule(router: self)
//        currentNavigationController?.pushViewController(signUpVC, animated: true)
    }

    private var currentNavigationController: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }
}
