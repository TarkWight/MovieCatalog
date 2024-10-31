//
//  AppRouter.swift
//  MovieCatalog
//
//  Created by Tark Wight on 27.10.2024.
//

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
    func showMainTabBarScreen()
}

final class AppRouter: RouterProtocol {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        if isUserAuthenticated() {
            showMainTabBarScreen()
        } else {
            showWelcomeScreen()
        }
    }

    private func isUserAuthenticated() -> Bool {
        return KeychainManager.shared.getToken() != nil
    }

    func showWelcomeScreen() {
        let welcomeVC = WelcomeModule.build(router: self)
        setRootViewController(UINavigationController(rootViewController: welcomeVC))
    }

    func showMainTabBarScreen() {
        // Create view controllers for each tab
//        let feedVC = FeedModule.createModule()
//        let moviesVC = MoviesModule.createModule()
//        let favoritesVC = FavoritesModule.createModule()
//        let profileVC = ProfileModule.createModule()
        
        // Initialize MainTabBarController with the view controllers
        let mainTabBarController = MainTabBarController()

        setRootViewController(mainTabBarController)
    }

    func showSignInScreen() {
        let signInVC = SignInModule.build(router: self)
        currentNavigationController?.pushViewController(signInVC, animated: true)
    }

    func showSignUpScreen() {
        let signUpVC = SignUpModule.build(router: self)
        currentNavigationController?.pushViewController(signUpVC, animated: true)
    }

    // Helper to set root view controller
    private func setRootViewController(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    private var currentNavigationController: UINavigationController? {
        if let navigationController = window.rootViewController as? UINavigationController {
            return navigationController
        } else if let tabBarController = window.rootViewController as? UITabBarController {
            return tabBarController.selectedViewController as? UINavigationController
        }
        return nil
    }
}
