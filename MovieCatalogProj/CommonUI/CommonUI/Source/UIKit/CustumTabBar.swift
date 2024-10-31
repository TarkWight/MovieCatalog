//
//  CustumTabBar.swift
//  CommonUI
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

open class CustomTabBarController: UITabBarController {

    // MARK: - Initialization
    public init(
        feedViewController: UIViewController,
        moviesViewController: UIViewController,
        favoritesViewController: UIViewController,
        profileViewController: UIViewController
    ) {
        super.init(nibName: nil, bundle: nil)
        setupViewControllers(feedVC: feedViewController,
                             moviesVC: moviesViewController,
                             favoritesVC: favoritesViewController,
                             profileVC: profileViewController)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViewControllers(
        feedVC: UIViewController,
        moviesVC: UIViewController,
        favoritesVC: UIViewController,
        profileVC: UIViewController
    ) {
        let feedTab = createTabBarItem(for: feedVC, title: NSLocalizedString("feed", comment: ""), image: UIImage(named: "tabbar_feed"))
        let moviesTab = createTabBarItem(for: moviesVC, title: NSLocalizedString("movies", comment: ""), image: UIImage(named: "tabbar_movies"))
        let favoritesTab = createTabBarItem(for: favoritesVC, title: NSLocalizedString("favorites", comment: ""), image: UIImage(named: "tabbar_favorites"))
        let profileTab = createTabBarItem(for: profileVC, title: NSLocalizedString("user_profile", comment: ""), image: UIImage(named: "tabbar_profile"))

        viewControllers = [feedTab, moviesTab, favoritesTab, profileTab]

        customizeTabBarAppearance()
    }

    private func createTabBarItem(for viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return UINavigationController(rootViewController: viewController)
    }

    private func customizeTabBarAppearance() {
        tabBar.tintColor = UIColor(named: "tabBarTint")
        tabBar.unselectedItemTintColor = UIColor(named: "tabBarUnselectedTint")
        tabBar.backgroundColor = UIColor(named: "tabBarBackground")
    }
}
