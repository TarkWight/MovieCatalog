//
//  MainCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 05.01.2025.
//

import UIKit

final class MainCoordinator {

    private let tabBarController: UITabBarController

    init() {
        self.tabBarController = UITabBarController()
    }

    func start() -> UITabBarController {
        setupTabBar()
        return tabBarController
    }

    private func setupTabBar() {
        let homeVC = createPlaceholderViewController(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0,
            logMessage: "Перешли на Home"
        )

        let favoritesVC = createPlaceholderViewController(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            tag: 1,
            logMessage: "Перешли на Favorites"
        )

        let profileVC = createPlaceholderViewController(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 2,
            logMessage: "Перешли на Profile"
        )

        tabBarController.viewControllers = [homeVC, favoritesVC, profileVC]
    }

    private func createPlaceholderViewController(
        title: String,
        image: UIImage?,
        tag: Int,
        logMessage: String
    ) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        vc.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)

        vc.view.addSubview(createPlaceholderLabel(text: logMessage))
        print(logMessage)

        return vc
    }

    private func createPlaceholderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: tabBarController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: tabBarController.view.centerYAnchor),
        ])
        
        return label
    }
}
