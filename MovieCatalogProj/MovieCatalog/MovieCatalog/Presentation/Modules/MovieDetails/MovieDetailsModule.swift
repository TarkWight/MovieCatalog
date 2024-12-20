//
//  MovieDetailsModule.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import SwiftUI
import ClientAPI

enum MovieDetailsModule {
    static func build(movie: MovieElementModel) -> some View {
        let viewModel = MovieDetailsViewModel(movie: movie)
        return MovieDetailsView(viewModel: viewModel)
    }
}

