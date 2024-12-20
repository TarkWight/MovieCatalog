//
//  SignUpViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import Foundation
import ClientAPI

final class SignUpViewModel {
    
    // MARK: - Properties
    var onRegistrationSuccess: (() -> Void)?
    var onRegistrationFailure: ((Error) -> Void)?
    
    var username: String = ""
    var email: String = ""
    var name: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var birthDate: String = ""
    var gender: String = "Мужчина"
    //TODO: - Исправить на gender: Gender
    
    private let authUseCase: AuthUseCaseProtocol
    private let router: RouterProtocol
    
    // MARK: - Initialization
    init(router: RouterProtocol, authUseCase: AuthUseCaseProtocol = AuthUseCase()) {
        self.authUseCase = authUseCase
        self.router = router
    }
    
    // MARK: - Registration
    func register() {
        guard isFormValid() else {
            onRegistrationFailure?(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid form data"]))
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDateValue = dateFormatter.date(from: birthDate)
        
        let genderValue: Gender? = gender == "Мужчина" ? .male : gender == "Женщина" ? .female : nil
        
        let registerModel = UserRegisterModel(
            userName: username,
            name: name,
            password: password,
            email: email,
            birthDate: birthDateValue,
            gender: genderValue
        )
        
        authUseCase.register(body: registerModel) { [weak self] success, error in
            if success {
                self?.onRegistrationSuccess?()
            } else if let error = error {
                self?.onRegistrationFailure?(error)
            }
        }
    }
    
    // MARK: - Form Validation
    private func isFormValid() -> Bool {
        return !username.isEmpty && !email.isEmpty && !name.isEmpty && !password.isEmpty && password == confirmPassword
    }
}
