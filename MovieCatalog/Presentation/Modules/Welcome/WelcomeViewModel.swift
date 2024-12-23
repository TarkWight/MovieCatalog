//
//  WelcomeViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 27.10.2024.
//

import Foundation

final class WelcomeViewModel {
    private weak var router: RouterProtocol?

    init(router: RouterProtocol) {
        self.router = router
    }

    func didTapSignIn() {
        router?.showSignInScreen()
    }

    func didTapSignUp() {
        router?.showSignUpScreen()
    }
}

