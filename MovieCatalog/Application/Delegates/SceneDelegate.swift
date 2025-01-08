//
//  SceneDelegate.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
//        customizeNavigationBarAppearance()
        
        let appFactory = AppFactory()
        let sceneFactory = SceneFactory(appFactory: appFactory)
        
        let appCoordinator = AppCoordinator(
            window: window,
            sceneFactory: sceneFactory
        )
        
        print("В сцен делегате все ок. Стартую апп координатор")
        appCoordinator.start()
        
        self.window = window
    }
    
    private func customizeNavigationBarAppearance() {
           let backImage = UIImage(named: "ChevronLeft")?.withRenderingMode(.alwaysTemplate)
           UINavigationBar.appearance().backIndicatorImage = backImage
           UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
           UINavigationBar.appearance().tintColor = UIColor(named: "AppDarkFaded")
           UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
       }
}
