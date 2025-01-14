//
//  MoviesViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation

final class MoviesViewModel: ViewModel {
    enum Event {
        case fetchInitialMovies
        case fetchMoreMovies
        case selectMovie(UUID)
    }

    // MARK: - Properties
    private let coordinator: MoviesCoordinatorProtocol
    private let fetchMovieListUseCase: FetchMovieListUseCase
    private let fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase
    
    var moviesBuffer: [Movie] = []
    private var pagination = Pagination()
    var isLoading = false

    var onMoviesLoaded: (() -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - Initialization
    init(
        coordinator: MoviesCoordinatorProtocol,
        fetchMovieListUseCase: FetchMovieListUseCase,
        fetchFavoriteMoviesUseCase: FetchFavoriteMoviesUseCase
    ) {
        self.coordinator = coordinator
        self.fetchMovieListUseCase = fetchMovieListUseCase
        self.fetchFavoriteMoviesUseCase = fetchFavoriteMoviesUseCase
    }

    // MARK: - Public Methods
    func handle(_ event: Event) {
        switch event {
        case .fetchInitialMovies:
            Task { await fetchInitialMovies() }
        case .fetchMoreMovies:
            Task { await fetchMoreMovies() }
        case .selectMovie(let movieId):
            coordinator.showMovieDetails(movieId: movieId)
        }
    }

    // MARK: - Private Methods
    private func fetchInitialMovies() async {
        guard pagination.page == .first else { return }
        pagination.reset()
        await fetchMovies()
    }

    private func fetchMoreMovies() async {
        guard !pagination.isLimitReached, !isLoading else { return }
        pagination.page = .next
        await fetchMovies()
    }

    private func fetchMovies() async {
        guard !isLoading else { return }
        isLoading = true
        onMoviesLoaded?()

        do {
            let newMovies = try await fetchMovieListUseCase.execute(page: pagination.page)
            let favorites = try await fetchFavoriteMoviesUseCase.execute()
            let favoriteIds = Set(favorites.map { $0.id })

            let filteredMovies = newMovies.filter { !favoriteIds.contains($0.id) }
            moviesBuffer.append(contentsOf: filteredMovies)

            Task { @MainActor in
                onMoviesLoaded?()
            }
        } catch {
            Task { @MainActor in
                onError?(error.localizedDescription)
            }
        }

        isLoading = false
    }
}
