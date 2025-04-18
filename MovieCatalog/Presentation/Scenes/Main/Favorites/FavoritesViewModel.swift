//
//  FavoritesViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation

final class FavoritesViewModel: ObservableObject, ViewModel {
    enum Event {
        case fetchFavorites
    }

    @Published var movies: [Movie] = []

    private let fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase
    private let coordinator: FavoritesCoordinatorProtocol
    init(coordinator: FavoritesCoordinatorProtocol,fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase) {
        self.coordinator = coordinator
        self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
    }

    func handle(_ event: Event) {
        switch event {
        case .fetchFavorites:
            fetchFavorites()
        }
    }

    private func fetchFavorites() {
        Task {
            do {
                movies = try await fetchFavoriteMoviesUseCase.execute()
            } catch {
                print("Failed to fetch favorite movies: \(error)")
            }
        }
    }
}
