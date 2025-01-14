//
//  MovieDetailsScreen.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import SwiftUI

struct MovieDetailsScreen: View {
    let movieId: UUID

    var body: some View {
        Text("Details for Movie \(movieId)")
            .font(.largeTitle)
            .padding()
    }
}
