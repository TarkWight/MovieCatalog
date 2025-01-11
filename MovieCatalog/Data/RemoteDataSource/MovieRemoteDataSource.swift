//
//  MovieRemoteDataSource.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class MovieRemoteDataSource {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension MovieRemoteDataSource {

    func fetchMovie(id: UUID) async throws -> MovieDTO {
        let config = MovieNetworkConfig.detailsById(id)
        return try await networkService.request(with: config)
    }

    func fetchMoviesPagedList(page: Int) async throws -> MoviesPagedResponse {
        let config = MovieNetworkConfig.listByPage(page)
        return try await networkService.request(with: config)
    }

    func addFavoriteMovie(movieId: UUID) async throws {
        let config = FavoriteMoviesNetworkConfig.add(movieId: movieId)
        try await networkService.request(with: config, useToken: true)
    }

    func deleteFavoriteMovie(movieId: UUID) async throws {
        let config = FavoriteMoviesNetworkConfig.delete(movieId: movieId)
        try await networkService.request(with: config, useToken: true)
    }

    func fetchFavoriteMovies() async throws -> MoviesResponse {
        let config = FavoriteMoviesNetworkConfig.list
        return try await networkService.request(with: config, useToken: true)
    }
}
