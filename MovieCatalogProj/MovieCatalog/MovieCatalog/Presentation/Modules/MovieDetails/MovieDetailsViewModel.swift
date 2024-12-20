//
//  MovieDetailsViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import Foundation
import ClientAPI

final class MovieDetailsViewModel {
    let movieId: UUID
    let movieName: String
    let moviePoster: String
    let movieCountry: String
    let movieYear: String
    let movieGenres: String
    
    init(movie: MovieElementModel) {
        self.movieId = movie.id ?? UUID()
        self.movieName = movie.name ?? "Unknown Title"
        self.moviePoster = movie.poster ?? ""
        self.movieCountry = movie.country ?? "Unknown Country"
        self.movieYear = movie.year.map { "\($0)" } ?? "Unknown Year"
        
        self.movieGenres = movie.genres?.compactMap { $0.name }.joined(separator: ", ") ?? "No Genres Available"
    }
}

