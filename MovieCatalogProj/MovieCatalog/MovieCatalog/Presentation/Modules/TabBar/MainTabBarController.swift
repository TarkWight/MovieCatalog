//
//  MainTabBarController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit
import CommonUI

final class MainTabBarController: CustomTabBarController {

    init() {
        // Configuration setup
        let viewControllers = [
            FeedModule.createModule(),
            MoviesModule.createModule(),
            FavoritesModule.createModule(),
            ProfileModule.createModule()
        ]
        let titles = [
            NSLocalizedString("feed", comment: ""),
            NSLocalizedString("movies", comment: ""),
            NSLocalizedString("favorites", comment: ""),
            NSLocalizedString("user_profile", comment: "")
        ]
        let images = ["tabbar_feed", "tabbar_movies", "tabbar_favorites", "tabbar_profile"]
        let gradientColors = [
            UIColor(named: "gradientLeftColor")?.cgColor ?? UIColor.orange.cgColor,
            UIColor(named: "gradientRightColor")?.cgColor ?? UIColor.red.cgColor
        ]
        let unselectedItemColor = UIColor(named: "AppGray") ?? UIColor.gray
        let backgroundColor = UIColor(named: "AppDarkFaded") ?? UIColor.black

        super.init(
            viewControllers: viewControllers,
            tabTitles: titles,
            tabImages: images,
            gradientColors: gradientColors,
            unselectedItemColor: unselectedItemColor,
            tabBarBackgroundColor: backgroundColor
        )

        customizeTabBarFrame()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Additional layout customization if needed
    private func customizeTabBarFrame() {
        tabBar.layer.cornerRadius = 16
        tabBar.layer.masksToBounds = true
        tabBar.frame = CGRect(
            x: 24,
            y: UIScreen.main.bounds.height - 64 - 29,
            width: UIScreen.main.bounds.width - 48,
            height: 64
        )
    }
}
