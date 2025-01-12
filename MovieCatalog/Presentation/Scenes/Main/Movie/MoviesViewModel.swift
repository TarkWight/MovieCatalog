//
//  MoviesViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


final class MoviesViewModel: ViewModel {
    enum Event {
        case fetchMovies
    }

    private let coordinator: MoviesCoordinatorProtocol
    private let fetchMovieListUseCase: FetchMovieListUseCase

    init(coordinator: MoviesCoordinatorProtocol, fetchMovieListUseCase: FetchMovieListUseCase) {
        self.coordinator = coordinator
        self.fetchMovieListUseCase = fetchMovieListUseCase
    }

    func handle(_ event: Event) {
        switch event {
        case .fetchMovies:
            fetchMovies()
        }
    }

    private func fetchMovies() {
        print("Fetching movie list...")
    }
}