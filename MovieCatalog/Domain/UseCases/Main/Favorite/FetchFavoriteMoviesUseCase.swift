//
//  FetchFavoriteMoviesUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class FetchFavoriteMoviesUseCase {

    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute() async throws -> [Movie] {
        return try await movieRepository.getFavoriteMovies()
    }
}
