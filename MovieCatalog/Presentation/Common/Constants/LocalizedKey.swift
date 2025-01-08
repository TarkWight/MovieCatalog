//
//  LocalizedKey.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

//
//  LocalizedKey.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

enum LocalizedKey {

    enum Welcome {
        static let title = NSLocalizedString("WelcomeTitle", comment: "")
        
        enum Button {
            static let login = NSLocalizedString("WelcomeLoginButton", comment: "")
            static let register = NSLocalizedString("RegisterButton", comment: "")
        }
    }

    enum Auth {
        enum LigIn {
            static let title = NSLocalizedString("LoginTitle", comment: "")
            static let button = NSLocalizedString("LoginButton", comment: "")
            
            enum TextField {
                static let username = NSLocalizedString("UsernameTextField", comment: "")
                static let password = NSLocalizedString("PasswordTextField", comment: "")
            }
        }
        
        enum Registration {
            static let title = NSLocalizedString("RegistrationTitle", comment: "")
        }
        
        
        
        
        enum Label {
            static let entrance = NSLocalizedString("Entrance", comment: "")
            static let registration = NSLocalizedString("Registration", comment: "")
        }

        enum Button {
            static let login = NSLocalizedString("LoginButton", comment: "")
            static let register = NSLocalizedString("RegisterButton", comment: "")
        }
        enum Action {
            static let logIn = NSLocalizedString("LogIn", comment: "")
            static let logOut = NSLocalizedString("LogOut", comment: "")
            static let register = NSLocalizedString("Register", comment: "")
            static let `continue` = NSLocalizedString("Continue", comment: "")
        }
    }

    enum ErrorMessage {
        static let error = NSLocalizedString("Error", comment: "")
        static let unknownError = NSLocalizedString("UnknownError", comment: "")
        static let invalidUsername = NSLocalizedString("InvalidUsername", comment: "")
        static let invalidLink = NSLocalizedString("InvalidLink", comment: "")

        static let loginFailed = NSLocalizedString("LoginFailed", comment: "")
        static let registrationFailed = NSLocalizedString("RegistrationFailed", comment: "")
        static let incorrectLink = NSLocalizedString("IncorrectLink", comment: "")

        enum Password {
            static let invalidPassword = NSLocalizedString("InvalidPassword", comment: "")
            static let invalidConfirmPassword = NSLocalizedString("InvalidConfirmPassword", comment: "")
        }

        enum Email {
            static let invalidUsername = NSLocalizedString("InvalidEmailUsername", comment: "")
            static let missingKeySign = NSLocalizedString("MissingKeySign", comment: "")
            static let invalidDomainPart = NSLocalizedString("InvalidDomainPart", comment: "")
            static let invalidTopLevelDomain = NSLocalizedString("InvalidTopLevelDomain", comment: "")
        }

        enum Network {
            static let missingURL = NSLocalizedString("MissingURL", comment: "")
            static let noConnect = NSLocalizedString("NoConnect", comment: "")
            static let invalidResponse = NSLocalizedString("InvalidResponse", comment: "")
            static let invalidData = NSLocalizedString("InvalidData", comment: "")
            static let decodingError = NSLocalizedString("DecodingError", comment: "")
            static let encodingError = NSLocalizedString("EncodingError", comment: "")
            static let requestFailed = NSLocalizedString("RequestFailed", comment: "")
        }
    }
}
