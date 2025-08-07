//
//  AppRoute.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

enum AppRoute: Equatable {
    case auth(AuthRoute)
    case tab(Tab)
    case fullScreenModal(FullScreenModalRoute)
    case sheetModal(SheetModalRoute)
}
