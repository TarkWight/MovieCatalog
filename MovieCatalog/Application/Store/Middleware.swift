//
//  Middleware.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

typealias Middleware<State, Action> =
    (
        _ state: State,
        _ action: Action,
        _ dispatch: @escaping (Action) -> Void
    ) -> Void
