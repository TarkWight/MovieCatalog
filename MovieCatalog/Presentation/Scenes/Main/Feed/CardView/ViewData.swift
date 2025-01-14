//
//  ViewData.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//

import Foundation


struct ViewData {
    let cardItems: [MovieDetailsItemViewModel]
    let listItems: [MovieDetailsItemViewModel]
}

struct MovieDetailsItemViewModel: Identifiable, Equatable {
    let id: UUID
    let title: String
    let year: String
    let country: String
    let posterURL: String?
    let rating: String
    let genres: [Genre]

    init(movie: MovieDetails) {
        self.id = movie.id
        self.title = movie.name ?? LocalizedKey.ErrorMessage.noStringAvailable
        self.year = "\(movie.year)"
        self.country = movie.country ?? LocalizedKey.ErrorMessage.noStringAvailable
        self.posterURL = movie.poster
        self.rating = movie.rating != nil ? "\(movie.rating!)" : LocalizedKey.ErrorMessage.noStringAvailable
        
        self.genres = movie.genres ?? []
    }
}
