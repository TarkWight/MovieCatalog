//
//  NavigationAction.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

enum NavigationAction {
    case push(AppRoute)
    case pop

    case presentSheet(SheetModalRoute)
    case dismissSheet

    case presentFullScreen(FullScreenModalRoute)
    case dismissFullScreen
}
