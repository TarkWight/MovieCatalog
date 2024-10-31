//
//  FeedModule.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

enum FeedModule {
    public static func createModule() -> UIViewController {
        let viewModel = FeedViewModel()
        let viewController = FeedViewController()
        return viewController
    }
}
