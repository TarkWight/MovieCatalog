//
//  FeedUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import Foundation
import ClientAPI

final class FeedUseCase {
    func fetchMovies(page: Int, completion: @escaping (MoviesPagedListModel?, Error?) -> Void) {
        MovieAPI.getMovies(page: page) { data, error in
            completion(data, error)
        }
    }
    
    func addFavorite(movieId: UUID, completion: @escaping (Error?) -> Void) {
        FavoriteMoviesAPI.addFavorite(movieId: movieId) { error in
            completion(error)
        }
    }
}

