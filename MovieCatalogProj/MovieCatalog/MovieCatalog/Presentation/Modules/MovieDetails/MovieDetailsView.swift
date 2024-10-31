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
            AsyncImage(url: URL(string: viewModel.moviePoster)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                case .failure:
                    Image("placeholder_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack{
                Text(viewModel.movieName)
                    .font(.title)
                    .padding(.top, 8)
                
                Text("\(viewModel.movieCountry) • \(viewModel.movieYear)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                
                Text(viewModel.movieGenres)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
            }
            Spacer()
        }
        .navigationTitle("Movie Details")
        .padding()
    }
}
