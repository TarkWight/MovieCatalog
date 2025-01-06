//
//  WelcomeViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import Foundation



import Foundation

final class WelcomeViewModel: ViewModel {
    private let coordinator: AuthCoordinatorProtocol

    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func handle(_ event: WelcomeViewEvent) {
        switch event {
        case .logInTapped:
            coordinator.showLogin()
        case .registrationTapped:
            coordinator.showRegistration()
        }
    }
}

enum WelcomeViewEvent {
    case logInTapped
    case registrationTapped
}
