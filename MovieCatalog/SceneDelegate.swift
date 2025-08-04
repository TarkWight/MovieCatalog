//
//  SceneDelegate.swift
//  MovieCatalog
//
//  Created by Tark Wight on 03.08.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)

        let viewController = ViewController()
        let uINavigationController = UINavigationController(
            rootViewController: viewController
        )

        window.rootViewController = uINavigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
