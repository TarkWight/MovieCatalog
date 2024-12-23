//
//  FeedUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import Foundation

final class FeedUseCase {
    func fetchMovies(page: Int, completion: @escaping (MoviesPagedListModel?, Error?) -> Void) {
        MovieAPI.getMovies(page: page) { data, error in
            completion(data, error)
        }
    }
    
    func addFavorite(movieId: UUID, completion: @escaping (Error?) -> Void) {
        FavoriteMoviesAPI.addFavorite(movieId: movieId) { error in
            print("blet, id - \(movieId)")
//            let authUseCase = AuthUseCase()

//            authUseCase.logout { success, error in
//                if success {
//                    print("Logout successful")
//                    // Выполните действия после успешного выхода, например, переход на экран входа
//                } else if let error = error {
//                    print("Logout failed with error: \(error.localizedDescription)")
//                    // Обработайте ошибку выхода
//                }
//            }

            completion(error)
        }
        print("Добавил в избранное")
    }
}

