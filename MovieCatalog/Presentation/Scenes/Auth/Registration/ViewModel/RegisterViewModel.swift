//
//  RegisterViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 09.01.2025.
//


import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func didUpdateLoadingState(isLoading: Bool)
    func didEncounterError(_ message: String)
    func didCompleteRegistration()
}

final class RegisterViewModel: ViewModel {
    
    weak var delegate: RegisterViewModelDelegate?
    
    private let personalInfo: UserInfoViewModel
    private let coordinator: AuthCoordinatorProtocol
    private let registerUseCase: RegisterUseCase
    private let validateUsernameUseCase: ValidateUsernameUseCase
    private let validateEmailUseCase: ValidateEmailUseCase
    private let validatePasswordUseCase: ValidatePasswordUseCase
    
    var username: String = ""
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var birthDate: Date = Date.now
    var gender: Gender = .male
    
    init(personalInfo: UserInfoViewModel,
         coordinator: AuthCoordinatorProtocol,
         registerUseCase: RegisterUseCase,
         validateUsernameUseCase: ValidateUsernameUseCase,
         validateEmailUseCase: ValidateEmailUseCase,
         validatePasswordUseCase: ValidatePasswordUseCase) {
        self.personalInfo = personalInfo
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
}

private extension RegisterViewModel {
    func registerTapped() {
        do {
            try validateUsernameUseCase.execute(username)
            try validateEmailUseCase.execute(email)
            try validatePasswordUseCase.execute(password)
            
            guard password == confirmPassword else {
                throw RegistrationValidationError.passwordsDoNotMatch
            }
            
            delegate?.didUpdateLoadingState(isLoading: true)
            
            let userRegister = UserRegister(
                userName: personalInfo.userName,
                name: personalInfo.name,
                password: password,
                email: personalInfo.email,
                birthDate: personalInfo.birthDate.ISO8601Format(),
                gender: personalInfo.gender
            )

            Task {
                do {
                    try await registerUseCase.execute(userRegister)
                    delegate?.didUpdateLoadingState(isLoading: false)
                    delegate?.didCompleteRegistration()
                } catch {
                    delegate?.didUpdateLoadingState(isLoading: false)
                    delegate?.didEncounterError(LocalizedKey.ErrorMessage.registrationFailed)
                }
            }
        } catch {
            delegate?.didEncounterError(ValidationErrorHandler.message(for: error))
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
