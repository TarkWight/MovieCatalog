//
//  CustumTabBar.swift
//  CommonUI
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

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
        let feedTab = createTabBarItem(for: feedVC, title: NSLocalizedString("feed", comment: ""), imageName: "tabbar_feed")
        let moviesTab = createTabBarItem(for: moviesVC, title: NSLocalizedString("movies", comment: ""), imageName: "tabbar_movies")
        let favoritesTab = createTabBarItem(for: favoritesVC, title: NSLocalizedString("favorites", comment: ""), imageName: "tabbar_favorites")
        let profileTab = createTabBarItem(for: profileVC, title: NSLocalizedString("user_profile", comment: ""), imageName: "tabbar_profile")

        viewControllers = [feedTab, moviesTab, favoritesTab, profileTab]

        customizeTabBarAppearance()
    }

    private func createTabBarItem(for viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        return UINavigationController(rootViewController: viewController)
    }

    private func customizeTabBarAppearance() {
        tabBar.backgroundColor = UIColor(named: "AppDarkFaded")
        tabBar.tintColor = .clear
        tabBar.unselectedItemTintColor = UIColor.blue // Синий цвет для невыбранных элементов
        
        tabBar.layer.cornerRadius = 16
        tabBar.layer.masksToBounds = true
        tabBar.frame = CGRect(x: 24,
                              y: UIScreen.main.bounds.height - 64 - 29,
                              width: UIScreen.main.bounds.width - 48,
                              height: 64)

        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .selected)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTabBarAppearance()
    }

    private func updateTabBarAppearance() {
        for (index, tabBarItem) in (tabBar.items ?? []).enumerated() {
            guard let tabBarItemView = tabBar.subviews[safe: index + 1] else { continue }
            let imageView = tabBarItemView.subviews.compactMap { $0 as? UIImageView }.first
            let titleLabel = tabBarItemView.subviews.compactMap { $0 as? UILabel }.first

            if tabBarItem == selectedViewController?.tabBarItem {
                // градиент к изображению и тексту выбранного элемента
                applyGradient(to: imageView)
                applyGradient(to: titleLabel)
            } else {
                // Синий цвет для невыбранных элементов
                imageView?.tintColor = UIColor.blue
                titleLabel?.textColor = UIColor.blue
                removeGradient(from: imageView)
                removeGradient(from: titleLabel)
            }
        }
    }

    private func applyGradient(to view: UIView?) {
        guard let view = view else { return }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(named: "gradientLeftColor")?.cgColor ?? UIColor.red.cgColor,
            UIColor(named: "gradientRightColor")?.cgColor ?? UIColor.orange.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = view.bounds

        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func removeGradient(from view: UIView?) {
        view?.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
