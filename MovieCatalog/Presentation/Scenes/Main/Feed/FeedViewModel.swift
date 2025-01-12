//
//  FeedViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


final class FeedViewModel: ViewModel {
    enum Event {
        case fetchFeed
    }

    private let coordinator: FeedCoordinatorProtocol
    private let fetchFeedUseCase: FetchMovieListUseCase
    private let fetchMovieDetailsUseCase: FetchFavoriteMoviesUseCase
    init(coordinator: FeedCoordinatorProtocol,
        fetchFeedUseCase: FetchMovieListUseCase,
         fetchMovieDetailsUseCase: FetchFavoriteMoviesUseCase
    ) {
        self.coordinator = coordinator
        self.fetchFeedUseCase = fetchFeedUseCase
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
    }

    func handle(_ event: Event) {
        switch event {
        case .fetchFeed:
            fetchFeed()
        }
    }

    private func fetchFeed() {
        print("Fetching feed...")
    }
}
