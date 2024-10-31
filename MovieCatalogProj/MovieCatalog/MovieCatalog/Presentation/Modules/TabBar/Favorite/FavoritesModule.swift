//
//  FavoritesModule.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import SwiftUI

enum FavoritesModule {
    public static func createModule() -> UIViewController {
        let viewModel = FavoritesViewModel()
        let favoritesScreen = FavoritesScreen(viewModel: viewModel)
        return UIHostingController(rootView: favoritesScreen)
    }
}


