//
//  FavoritesScreen.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import SwiftUI

struct FavoritesScreen: View {
    let factory: SceneFactory
    @StateObject private var viewModel: FavoritesViewModel

    init(factory: SceneFactory, viewModel: FavoritesViewModel) {
        self.factory = factory
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("FavoritesScreen")

    }
}
