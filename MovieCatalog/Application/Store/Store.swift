//
//  Store.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Combine

final class Store<State, Action>: ObservableObject where State: Equatable {

    @Published private(set) var state: State
    private let reducer: (inout State, Action) -> Void

    init(
        initialState: State,
        reducer: @escaping (inout State, Action) -> Void
    ) {
        self.state = initialState
        self.reducer = reducer
    }

    func send(_ action: Action) {
        reducer(&state, action)
    }
}
