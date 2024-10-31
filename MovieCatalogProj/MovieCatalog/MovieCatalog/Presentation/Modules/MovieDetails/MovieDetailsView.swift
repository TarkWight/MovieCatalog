//
//  MovieDetailsView.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import SwiftUI

struct MovieDetailsView: View {
    let viewModel: MovieDetailsViewModel
    
    var body: some View {
        VStack {
            Image(viewModel.moviePoster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
            
            Text(viewModel.movieName)
                .font(.title)
                .padding(.top, 8)
            
            Text("\(viewModel.movieCountry) - \(viewModel.movieYear)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
            
            Text(viewModel.movieGenres)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Movie Details")
        .padding()
    }
}
