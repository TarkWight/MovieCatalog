//
//  MoviesUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 02.11.2024.
//


import Foundation

final class MoviesUseCase {
    func fetchMovies(page: Int, completion: @escaping (Result<[MovieElementModel], Error>) -> Void) {
        MovieAPI.getMovies(page: page) { data, error in
            if let data = data, let movies = data.movies {
                completion(.success(movies))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func fetchFavoriteMovies(completion: @escaping (Result<[MovieElementModel], Error>) -> Void) {
        FavoriteMoviesAPI.getFavorites { data, error in
            if let data = data, let movies = data.movies {
                completion(.success(movies))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func addFavorite(movieId: UUID, completion: @escaping (Error?) -> Void) {
        FavoriteMoviesAPI.addFavorite(movieId: movieId) { error in
            completion(error)
        }
    }
    
    func deleteFavorite(movieId: UUID, completion: @escaping (Error?) -> Void) {
        FavoriteMoviesAPI.deleteFavorite(movieId: movieId) { error in
            completion(error)
        }
    }
    
    func fetchMovieDetails(movieId: UUID, completion: @escaping (Result<MovieDetailsModel, Error>) -> Void) {
        MovieAPI.getMovieDetails(movieId: movieId) { data, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
