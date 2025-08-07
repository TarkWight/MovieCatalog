//
//  AppReducer.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

func appReducer(state: AppState, action: AppAction) -> AppState {
    var newState = state

    switch action {
    // MARK: –– start application
    case .appStarted:
        if newState.authStatus == .authenticated {
            newState.mainFlow.selectedTab = .feed
            newState.routeStack = [.tab(.feed)]
        } else {
            newState.routeStack = [.auth(.welcome)]
        }

    // MARK: - outside auth status changed
    case .authStatusChanged(let status):
        newState.authStatus = status
        if status == .authenticated {
            newState.mainFlow.selectedTab = .feed
            newState.routeStack = [.tab(.feed)]
        } else {
            newState.routeStack = [.auth(.welcome)]
        }

    // MARK: - inside auth status changed
    case .authentication(let authAction):
        switch authAction {
        case .loginRequest:
            newState.login.isLoading = true
            newState.login.errorMessage = nil

        case .registerRequest:
            newState.register.isLoading = true
            newState.register.errorMessage = nil

        case .login:
            newState.login.isLoading = false
            newState.authStatus = .authenticated
            newState.routeStack = [.tab(.feed)]

        case .register:
            newState.register.isLoading = false
            newState.authStatus = .authenticated
            newState.routeStack = [.tab(.feed)]

        case .logout, .autoLogout:
            newState.authStatus = .unauthenticated
            newState.routeStack = [.auth(.welcome)]
        }

    // MARK: –– push/pop/modal
    case .navigation(let nav):
        switch nav {
        case .push(let route):
            newState.routeStack.append(route)
        case .pop:
            if newState.routeStack.count > 1 {
                newState.routeStack.removeLast()
            }
        case .presentSheet(let sheetView):
            newState.routeStack.append(.sheetModal(sheetView))
        case .dismissSheet:
            if case .sheetModal = newState.routeStack.last {
                newState.routeStack.removeLast()
            }
        case .presentFullScreen(let fullScreenView):
            newState.routeStack.append(.fullScreenModal(fullScreenView))
        case .dismissFullScreen:
            if case .sheetModal = newState.routeStack.last {
                newState.routeStack.removeLast()
            }
        }

    // MARK: –– legacy pathChanged
    // case .pathChanged(let newStack):
    //     newState.routeStack = newStack
    }

    return newState
}
