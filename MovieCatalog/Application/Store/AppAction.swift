//
//  AppAction.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

enum AppAction {
    case pathChanged(to: AppRoute)

    case appStarted

    case authStatusChanged(AuthStatus)
    case authentication(AuthAction)
}
