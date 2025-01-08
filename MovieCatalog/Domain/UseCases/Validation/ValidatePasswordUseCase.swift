//
//  ValidatePasswordUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 08.01.2025.
//

import Foundation

final class ValidatePasswordUseCase {

    enum PasswordValidationError: Error {
        case invalidPassword
    }

    private enum Constants {
        static let minPasswordLength = 6
    }

    func execute(_ password: String) throws {
        guard password.count >= Constants.minPasswordLength else {
            throw PasswordValidationError.invalidPassword
        }
    }
}
