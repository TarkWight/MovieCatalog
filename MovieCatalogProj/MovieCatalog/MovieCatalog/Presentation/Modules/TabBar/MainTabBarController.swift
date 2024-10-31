//
//  MainTabBarController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

// MainTabBarController.swift

import UIKit
import CommonUI

final class MainTabBarController: CustomTabBarController {

    // MARK: - Initialization
    init() {
        let feedVC = FeedModule.createModule()
        let moviesVC = MoviesModule.createModule()
        let favoritesVC = FavoritesModule.createModule()
        let profileVC = ProfileModule.createModule()

        super.init(
            feedViewController: feedVC,
            moviesViewController: moviesVC,
            favoritesViewController: favoritesVC,
            profileViewController: profileVC
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
