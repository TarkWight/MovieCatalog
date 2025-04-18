//
//  SceneDelegate.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let appFactory = AppFactory()
        let sceneFactory = SceneFactory(appFactory: appFactory)
        
        let keychainService = KeychainService()
        let networkService = NetworkService(keychainService: keychainService)
        
        let appCoordinator = AppCoordinator(
            window: window,
            sceneFactory: sceneFactory,
            networkService: networkService
        )
        self.appCoordinator = appCoordinator
        
        self.window = window
    }
}
