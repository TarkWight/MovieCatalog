//
//  FeedViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation

final class FeedViewModel: ViewModel {
    enum Event {
        case fetchInitialMovies
        case loadMoreMovies
        case addFavorite(UUID)
        case hideMovie(UUID)
        case showMovieDetails(UUID)
    }

    private let coordinator: FeedCoordinatorProtocol
    private let fetchMovieListUseCase: FetchMovieListUseCase
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let ignoreListUseCase: AddMovieToIgnoreListUseCase
    private let addFavoriteUseCase: AddFavoriteMovieUseCase

    private var moviesBuffer: [MovieDetails] = []
    private var hiddenMovies: Set<UUID> = []
    private var pagination = Pagination()

    var onLoading: ((Bool) -> Void)?
    var onViewDataUpdated: ((ViewData) -> Void)?
    var onError: ((String) -> Void)?

    init(coordinator: FeedCoordinatorProtocol,
         fetchMovieListUseCase: FetchMovieListUseCase,
         fetchMovieDetailsUseCase: FetchMovieDetailsUseCase,
         ignoreListUseCase: AddMovieToIgnoreListUseCase,
         addFavoriteUseCase: AddFavoriteMovieUseCase
    ) {
        self.coordinator = coordinator
        self.fetchMovieListUseCase = fetchMovieListUseCase
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.ignoreListUseCase = ignoreListUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
    }

    func handle(_ event: Event) {
        switch event {
        case .fetchInitialMovies:
            Task { await fetchInitialMovies() }
        case .loadMoreMovies:
            Task { await fetchMoreMovies() }
        case .addFavorite(let id):
            Task { await addFavoriteMovie(id: id) }
        case .hideMovie(let id):
            Task { await hideMovie(id: id) }
        case .showMovieDetails(let id):
            coordinator.showMovieDetails(movieId: id)
        }
    }
}

private extension FeedViewModel {
    func fetchInitialMovies() async {
        guard pagination.page == .first else { return }
        pagination.reset()
        await fetchMovies()
    }

    func fetchMoreMovies() async {
        guard !pagination.isLimitReached else { return }
        pagination.page = .next
        await fetchMovies()
    }

    func fetchMovies() async {
        onLoading?(true)

        do {
            let movies = try await fetchMovieListUseCase.execute(page: pagination.page)
            let detailedMovies = try await fetchMovieDetailsUseCase.execute(movies: movies)
            let filteredMovies = detailedMovies.filter { !hiddenMovies.contains($0.id) }

            moviesBuffer.append(contentsOf: filteredMovies)
            onViewDataUpdated?(makeViewData())

            pagination.pageCount = movies.count < 20 ? pagination.currentPage : nil
        } catch {
            onError?(error.localizedDescription)
        }

        onLoading?(false)
    }

    func addFavoriteMovie(id: UUID) async {
        do {
            try await addFavoriteUseCase.execute(movieId: id)
        } catch {
            onError?(error.localizedDescription)
        }
    }

    func hideMovie(id: UUID) async {
        hiddenMovies.insert(id)
        moviesBuffer.removeAll { $0.id == id }
        onViewDataUpdated?(makeViewData())
        await fetchMoreMovies()
    }

    func makeViewData() -> ViewData {
        let numberOfCards = 4
        let cardItems = moviesBuffer.prefix(numberOfCards).map { MovieDetailsItemViewModel(movie: $0) }
        let listItems = moviesBuffer.dropFirst(numberOfCards).map { MovieDetailsItemViewModel(movie: $0) }
        return ViewData(cardItems: Array(cardItems), listItems: Array(listItems))
    }
}

extension FeedViewModel {
    func getCurrentMovie() -> MovieDetails? {
        return moviesBuffer.first
    }
}
