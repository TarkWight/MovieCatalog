//
//  MainTabBarController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

final class MainCoordinatorViewController: UITabBarController {

    enum TabBarItem: Int, CaseIterable {
        case feed
        case movies
        case favorites
        case profile
    }
    
    private let selected = TabBarItem.feed
    
    private let factory: SceneFactory
    private let feedCoordinator: FeedCoordinator
    private let moviesCoordinator: MoviesCoordinator
    private let favoritesCoordinator: FavoritesCoordinator
    private let profileCoordinator: ProfileCoordinator

    init(factory: SceneFactory) {
        self.factory = factory
        feedCoordinator = .init(factory: factory)
        moviesCoordinator = .init(sceneFactory: factory)
        favoritesCoordinator = .init(sceneFactory: factory)
        profileCoordinator = .init(factory: factory)

        super.init(nibName: nil, bundle: nil)

        configureTabBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTabBar() {
        let feedNavController = feedCoordinator.navigationController
        feedNavController.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "list.bullet"),
            tag: 0
        )

        let moviesNavController = moviesCoordinator.navigationController
        moviesNavController.tabBarItem = UITabBarItem(
            title: "Фильмы",
            image: UIImage(systemName: "film"),
            tag: 1
        )

        let favoritesNavController = favoritesCoordinator.navigationController
        favoritesNavController.tabBarItem = UITabBarItem(
            title: "Избранное",
            image: UIImage(systemName: "star"),
            tag: 2
        )

        let profileNavController = profileCoordinator.navigationController
        profileNavController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person"),
            tag: 3
        )

        viewControllers = [feedNavController, moviesNavController, favoritesNavController, profileNavController]

        setupTabBarAppearance()
    }

    @MainActor
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground

        UITabBar.appearance().tintColor = UIColor.systemBlue
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
