//
//  FetchMovieListUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class FetchMovieListUseCase {
    
    private let movieRepository: MovieRepository

    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }

    func execute(page: Page?) async throws -> [Movie] {
        try await movieRepository.getMovieList(page: page)
    }
}
