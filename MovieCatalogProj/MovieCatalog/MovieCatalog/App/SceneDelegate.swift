//
//  SceneDelegate.swift
//  MovieCatalog
//
//  Created by Tark Wight on 15.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var router: AppRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let appRouter = AppRouter(window: window)

        self.window = window
        self.router = appRouter
        appRouter.start()
    }
}
