//
//  SignInViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 30.10.2024.
//

import Foundation

final class SignInViewModel {
    private weak var router: RouterProtocol?
    
    var onLoginFailure: ((Error) -> Void)?
    
    init(router: RouterProtocol) {
        self.router = router
    }

    func login(username: String?, password: String?) {
        guard let username = username, !username.isEmpty,
              let password = password, !password.isEmpty else {
            return
        }

        let credentials = LoginCredentials(username: username, password: password)
        
        AuthAPI.login(body: credentials) { [weak self] success, error in
            if success {
                print("Login is success!")
                self?.router?.showMainTabBarScreen()
            } else if let error = error {
                self?.onLoginFailure?(error)
            }
        }
    }
  
}

