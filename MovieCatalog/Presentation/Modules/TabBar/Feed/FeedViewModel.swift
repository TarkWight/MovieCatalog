//
//  FeedViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import Foundation

final class FeedViewModel {
    private let useCase = FeedUseCase()
    private var moviesBuffer: [MovieElementModel] = []
    private var hiddenMovies: Set<UUID> = []
    
    var onLoading: ((Bool) -> Void)?
    var onMoviesFetched: ((MovieElementModel) -> Void)?
    var onError: ((Error) -> Void)?
    
    func fetchRandomMovie() {
        if moviesBuffer.isEmpty {
            fetchMovies(page: 1)
        } else {
            showRandomMovie()
        }
    }
    
    private func fetchMovies(page: Int) {
        onLoading?(true)
        
        useCase.fetchMovies(page: page) { [weak self] data, error in
            self?.onLoading?(false)
            
            if let error = error {
                self?.onError?(error)
                return
            }
            
            if let movies = data?.movies {
                self?.moviesBuffer.append(contentsOf: movies.filter { movie in
                    if let id = movie.id { return !(self?.hiddenMovies.contains(id) ?? false) }
                    return false
                })
                self?.showRandomMovie()
                
                // Подгружаем дополнительные фильмы, если осталось 2
                if self?.moviesBuffer.count ?? 0 <= 2 {
                    self?.fetchMovies(page: page + 1)
                }
            }
        }
    }
    
    private func showRandomMovie() {
        guard !moviesBuffer.isEmpty else {
            fetchMovies(page: 2)
            return
        }
        
        let randomMovie = moviesBuffer.remove(at: Int.random(in: 0..<moviesBuffer.count))
        onMoviesFetched?(randomMovie)
    }
    
    func addFavoriteMovie(_ movieId: UUID) {
        useCase.addFavorite(movieId: movieId) { [weak self] error in
            if let error = error {
                self?.onError?(error)
                return
            }
            self?.fetchRandomMovie()
        }
    }
    
    func hideMovie(_ movieId: UUID) {
        hiddenMovies.insert(movieId)
        fetchRandomMovie()
    }
}
