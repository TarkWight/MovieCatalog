//
//  MoviesModule.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit


enum MoviesModule {
    public static func createModule() -> UIViewController {
        let viewModel = MoviesViewModel()
        let viewController = MoviesViewController(viewModel: viewModel)
        return viewController
    }
}

