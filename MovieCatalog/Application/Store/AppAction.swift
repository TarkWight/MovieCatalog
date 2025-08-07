//
//  AppAction.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

enum AppAction {
    case appStarted

    case authStatusChanged(AuthStatus)
    case authentication(AuthAction)

    case navigation(NavigationAction)
}
