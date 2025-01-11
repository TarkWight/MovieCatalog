//
//  AddFavoriteMovieUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class AddFavoriteMovieUseCase {

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(movieId: UUID) async throws {
        try await movieRepository.addFavoriteMovie(id: movieId)
    }
}
