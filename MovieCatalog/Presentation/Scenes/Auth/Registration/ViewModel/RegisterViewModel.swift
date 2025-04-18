//
//  RegisterViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 09.01.2025.
//


import Foundation

final class RegisterViewModel: ViewModel {
    private let registerUseCase: RegisterUseCase
    private let validateUsernameUseCase: ValidateUsernameUseCase
    private let validateEmailUseCase: ValidateEmailUseCase
    private let validatePasswordUseCase: ValidatePasswordUseCase
    private let coordinator: AuthCoordinatorProtocol

    var onLoadingStateChanged: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onRegistrationSuccess: (() -> Void)?

    var username: String = ""
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var birthDate: Date = Date.now
    var gender: Gender = .male

    init(
        coordinator: AuthCoordinatorProtocol,
        registerUseCase: RegisterUseCase,
        validateUsernameUseCase: ValidateUsernameUseCase,
        validateEmailUseCase: ValidateEmailUseCase,
        validatePasswordUseCase: ValidatePasswordUseCase
    ) {
        self.coordinator = coordinator
        self.registerUseCase = registerUseCase
        self.validateUsernameUseCase = validateUsernameUseCase
        self.validateEmailUseCase = validateEmailUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
    }

    func handle(_ event: RegisterViewEvent) {
        switch event {
        case .registerTapped:
            registerTapped()
        case .usernameChanged(let newUsername):
            username = newUsername
        case .emailChanged(let newEmail):
            email = newEmail
        case .nameChanged(let newName):
            name = newName
        case .passwordChanged(let newPassword):
            password = newPassword
        case .confirmPasswordChanged(let newConfirmPassword):
            confirmPassword = newConfirmPassword
        case .birthDateChanged(let newBirthDate):
            birthDate = newBirthDate
        case .genderChanged(let newGender):
            gender = newGender
        }
    }

    private func registerTapped() {
        do {
            try validateUsernameUseCase.execute(username)
            try validateEmailUseCase.execute(email)
            try validatePasswordUseCase.execute(password)

            guard password == confirmPassword else {
                throw RegistrationValidationError.passwordsDoNotMatch
            }

            onLoadingStateChanged?(true)

            let userRegister = UserRegister(
                userName: username,
                name: name,
                password: password,
                email: email,
                birthDate: birthDate.ISO8601Format(),
                gender: gender
            )

            Task {
                do {
                    try await registerUseCase.execute(userRegister)
                    onLoadingStateChanged?(false)
                    coordinator.didCompleteLogin()
                } catch {
                    onLoadingStateChanged?(false)
                    onError?(LocalizedKey.ErrorMessage.registrationFailed)
                }
            }
        } catch {
            onError?(ValidationErrorHandler.message(for: error))
        }
    }
}


enum RegisterViewEvent {
    case registerTapped
    case usernameChanged(String)
    case emailChanged(String)
    case nameChanged(String)
    case passwordChanged(String)
    case confirmPasswordChanged(String)
    case birthDateChanged(Date)
    case genderChanged(Gender)
}

enum RegistrationValidationError: Error {
    case passwordsDoNotMatch
}
