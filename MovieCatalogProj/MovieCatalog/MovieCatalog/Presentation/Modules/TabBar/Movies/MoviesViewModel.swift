//
//  MoviesViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import Foundation
import ClientAPI

final class MoviesViewModel {
    private let useCase = MoviesUseCase()
    private var currentPage = 1
    
    var favoriteMovies: [MovieElementModel] = []
    var allMovies: [MovieElementModel] = []
    
    var onMoviesUpdate: (([MovieElementModel]) -> Void)?
    var onFavoriteMoviesUpdate: (([MovieElementModel]) -> Void)?
    var onError: ((Error) -> Void)?
    
    init() {
        loadInitialMovies()
        loadFavoriteMovies()
    }
    
    func loadInitialMovies() {
        useCase.fetchMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.allMovies = movies
                self?.onMoviesUpdate?(Array(movies.prefix(5)))
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }

    
    func loadFavoriteMovies() {
        useCase.fetchFavoriteMovies { [weak self] result in
            switch result {
                case .success(let movies):
                    self?.favoriteMovies = movies
                    self?.onFavoriteMoviesUpdate?(movies)
                case .failure(let error):
                    self?.onError?(error)
            }
        }
    }
    
    func loadMoreMoviesIfNeeded(currentIndex: Int) {
        if currentIndex >= allMovies.count - 6 {
            currentPage += 1
            useCase.fetchMovies(page: currentPage) { [weak self] result in
                switch result {
                    case .success(let movies):
                        self?.allMovies.append(contentsOf: movies)
                        self?.onMoviesUpdate?(self?.allMovies ?? [])
                    case .failure(let error):
                        self?.onError?(error)
                }
            }
        }
    }
}

