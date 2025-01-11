//
//  FetchMovieUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class FetchMovieUseCase {

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(movieId: UUID) async throws -> Movie {
        try await movieRepository.getFavoriteMovies()
        return try await movieRepository.getMovie(id: movieId)
    }
}
