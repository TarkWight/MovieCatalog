//
//  AppState.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Foundation

struct AppState: Equatable {
    var authStatus: AuthStatus = .unauthenticated
    var routeStack: [AppRoute] = []

    var welcome: WelcomeState = .init()
    var login: LoginState = .init()
    var register: RegisterState = .init()

    var mainFlow: MainFlowState = .init()
}

struct WelcomeState: Equatable {}

struct LoginState: Equatable {
    var email: String = ""
    var password: String = ""
    var isLoading = false
    var errorMessage: String?
}

struct RegisterState: Equatable {
    var username: String = ""
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var birthdate: String = ""
    var gender: Gender? = .male
    var isLoading = false
    var errorMessage: String?
}

struct MainFlowState: Equatable {
    var selectedTab: Tab = .feed
}
