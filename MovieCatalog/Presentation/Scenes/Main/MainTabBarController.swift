//
//  MainTabBarController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

final class MainCoordinatorViewController: UITabBarController {

    // MARK: - TabBarItem Enum
    enum TabBarItem: Int, CaseIterable {
        case feed
        case movies
        case favorites
        case profile
    }

    // MARK: - Properties
    private let factory: SceneFactory
    private let feedCoordinator: FeedCoordinator
    private let moviesCoordinator: MoviesCoordinator
    private let favoritesCoordinator: FavoritesCoordinator
    private let profileCoordinator: ProfileCoordinator

    // MARK: - Initializer
    init(factory: SceneFactory) {
        self.factory = factory
        
        self.feedCoordinator = FeedCoordinator(factory: factory)
        self.moviesCoordinator = MoviesCoordinator(sceneFactory: factory)
        self.favoritesCoordinator = FavoritesCoordinator(sceneFactory: factory)
        self.profileCoordinator = ProfileCoordinator(factory: factory)

        super.init(nibName: nil, bundle: nil)

        configureTabBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    private func configureTabBar() {
        let feedNavController = feedCoordinator.navigationController
        feedNavController.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(named: "tab-bar-feed"),
            tag: TabBarItem.feed.rawValue
        )

        let moviesNavController = moviesCoordinator.navigationController
        moviesNavController.tabBarItem = UITabBarItem(
            title: "Фильмы",
            image: UIImage(named: "tab-bar-movie"),
            tag: TabBarItem.movies.rawValue
        )

        let favoritesNavController = favoritesCoordinator.navigationController
        favoritesNavController.tabBarItem = UITabBarItem(
            title: "Избранное",
            image: UIImage(named: "tab-bar-favorite"),
            tag: TabBarItem.favorites.rawValue
        )

        let profileNavController = profileCoordinator.navigationController
        profileNavController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(named: "tab-bar-profile"),
            tag: TabBarItem.profile.rawValue
        )

        viewControllers = [feedNavController, moviesNavController, favoritesNavController, profileNavController]

        setupTabBarAppearance()
    }

    // MARK: - TabBar Appearance
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "AppDarkFaded") ?? .darkGray

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "gradientLeftColor")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(named: "gradientLeftColor") ?? .orange
        ]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.lightGray
        ]

        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }
    }
}
