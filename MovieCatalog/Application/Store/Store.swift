//
//  Store.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Combine

final class Store: ObservableObject {
    @Published private(set) var state: AppState

    private let reducer: (AppState, AppAction) -> AppState
    private let middlewares: [Middleware<AppState, AppAction>]

    init(
        initial: AppState,
        reducer: @escaping (AppState, AppAction) -> AppState,
        middlewares: [Middleware<AppState, AppAction>] = []
    ) {
        self.state = initial
        self.reducer = reducer
        self.middlewares = middlewares
    }

    func dispatch(_ action: AppAction) {
        let newState = reducer(state, action)
        if newState != state {
            state = newState
        }
        let dispatchFn: (AppAction) -> Void = { [weak self] in
            self?.dispatch($0)
        }
        middlewares.forEach { $0(state, action, dispatchFn) }
    }
}
