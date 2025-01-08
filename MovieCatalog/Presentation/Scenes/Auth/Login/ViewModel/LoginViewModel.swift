//
//  LoginViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 06.01.2025.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func didUpdateLoadingState(isLoading: Bool)
    func didEncounterError(_ message: String)
    func didCompleteLogin()
}

final class LoginViewModel: ViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    private let coordinator: AuthCoordinatorProtocol
    private let loginUseCase: LoginUseCase
    
    private var username: String = ""
    private var password: String = ""

    init(coordinator: AuthCoordinatorProtocol, loginUseCase: LoginUseCase) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }

    func handle(_ event: LoginViewEvent) {
        switch event {
        case .logInTapped:
            logInTapped()
        case .registerTapped:
            coordinator.showRegistration()
        case .usernameChanged(let newUsername):
            username = newUsername
        case .passwordChanged(let newPassword):
            password = newPassword
        }
    }
}

private extension LoginViewModel {
    func logInTapped() {
        guard !username.isEmpty, !password.isEmpty else {
            delegate?.didEncounterError(LocalizedKey.ErrorMessage.invalidUsername)
            return
        }
        
        delegate?.didUpdateLoadingState(isLoading: true)
        
        Task {
            do {
                try await loginUseCase.execute(username: username, password: password)
                delegate?.didEncounterError("")
                delegate?.didUpdateLoadingState(isLoading: false)
                delegate?.didCompleteLogin()
            } catch {
                delegate?.didUpdateLoadingState(isLoading: false)
                delegate?.didEncounterError(LocalizedKey.ErrorMessage.loginFailed)
            }
        }
    }
}


enum LoginViewEvent {
    case logInTapped
    case registerTapped
    case usernameChanged(String)
    case passwordChanged(String)
}
