//
//  FavoritesScreen.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import SwiftUI

struct FavoritesScreen: View {
    let viewModel: FavoritesViewModel
    
    public var body: some View {
        Text("Favorites Screen")
            .navigationTitle(NSLocalizedString("favorites", comment: ""))
    }
}


