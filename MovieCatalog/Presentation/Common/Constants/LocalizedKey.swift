//
//  LocalizedKey.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//


import Foundation

enum LocalizedKey {

   

    enum Сomponents {
        enum Gender {
            static let genderMale = NSLocalizedString("GenderMale", comment: "Gender male text")
            static let genderFemale = NSLocalizedString("GenderFemale", comment: "Gender female text")
        }
    }
    
    enum Profile {
        enum Label {
            static let title = NSLocalizedString("PersonalInformation", comment: "lable")
        }
        enum Edit {
            static let username = NSLocalizedString("Username", comment: "edit profile")
            static let name = NSLocalizedString("Name", comment: "edit profile")
            static let gender = NSLocalizedString("Gender", comment: "edit profile")
            static let email = NSLocalizedString("Email", comment: "edit profile")
            static let birthdate = NSLocalizedString("Birthdate", comment: "edit profile")
            static let password = NSLocalizedString("Password", comment: "edit profile")
            static let confirmPassword = NSLocalizedString("ConfirmPassword", comment: "edit profile")
            static let avatarLink = NSLocalizedString("AvatarLink", comment: "edit profile")
        }
        enum Button {
            static let friends = NSLocalizedString("MyFriends", comment: "in profile")
            static let save = NSLocalizedString("Save", comment: "edit profile")
            static let cancel = NSLocalizedString("Cancel", comment: "edit profile")
        }
        
        enum Greeting{
            static let morning = NSLocalizedString("Morning", comment: "")
            static let day = NSLocalizedString("Day", comment: "")
            static let evening = NSLocalizedString("Evening", comment: "")
            static let night = NSLocalizedString("Night", comment: "")
        }
    }
    
    
    enum Welcome {
        static let title = NSLocalizedString("WelcomeTitle", comment: "")
        
        enum Button {
            static let login = NSLocalizedString("WelcomeLoginButton", comment: "")
            static let register = NSLocalizedString("RegisterButton", comment: "That's exactly what you need")
        }
    }
    
    
    enum Auth {
        enum LigIn {
            static let title = NSLocalizedString("LoginTitle", comment: "")
            static let button = NSLocalizedString("LoginButton", comment: "")
            
            enum TextField {
                static let username = NSLocalizedString("Username", comment: "")
                static let password = NSLocalizedString("Password", comment: "")
            }
        }
        
        enum Registration {
            static let title = NSLocalizedString("Registration", comment: "")
            static let button = NSLocalizedString("RegisterButton", comment: "")
            enum TextField {
                static let username = NSLocalizedString("Username", comment: "edit profile")

                static let email = NSLocalizedString("Email", comment: "edit profile")
                static let name = NSLocalizedString("Name", comment: "edit profile")
                static let password = NSLocalizedString("Password", comment: "edit profile")
                static let confirmPassword = NSLocalizedString("ConfirmPassword", comment: "edit profile")
                static let birthdate = NSLocalizedString("Birthdate", comment: "edit profile")
            }
        }
        
        
        
        
        
        enum Label {
            static let entrance = NSLocalizedString("Entrance", comment: "")
            static let registration = NSLocalizedString("Registration", comment: "")
        }

        enum Button {
            static let login = NSLocalizedString("LoginButton", comment: "")
            static let register = NSLocalizedString("RegisterButton", comment: "")
        }

    }

    enum TabBarTitle {
        static let feed = NSLocalizedString("tb-feed", comment: "")
        static let movie = NSLocalizedString("tb-movie", comment: "")
        static let favorite = NSLocalizedString("tb-favorite", comment: "")
        static let user_profile = NSLocalizedString("tb-profile", comment: "")
    }
    
  

    
    enum ErrorMessage {
        static let noStringAvailable = NSLocalizedString("NoStringAvailable", comment: "")
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

        enum Profile {
            static let notFound = NSLocalizedString("ProfileNotFound", comment: "")
            static let updateFailed = NSLocalizedString("ProfileUpdateFailed", comment: "")
            static let deleteFailed = NSLocalizedString("ProfileDeleteFailed", comment: "")
        }
        
        enum Movie {
            static let notFound = NSLocalizedString("MovieNotFound", comment: "")
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


