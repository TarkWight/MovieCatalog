//
//  AuthUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import Foundation
import ClientAPI

protocol AuthUseCaseProtocol {
    func login(credentials: LoginCredentials, completion: @escaping (Bool, Error?) -> Void)
    func register(body: UserRegisterModel, completion: @escaping (Bool, Error?) -> Void)
    func logout(completion: @escaping (Bool, Error?) -> Void)
}


final class AuthUseCase: AuthUseCaseProtocol {
    
    // MARK: - Login
    func login(credentials: LoginCredentials, completion: @escaping (Bool, Error?) -> Void) {
        AuthAPI.login(body: credentials) { success, error in
            completion(success, error)
        }
    }
    
    // MARK: - Register
    func register(body: UserRegisterModel, completion: @escaping (Bool, Error?) -> Void) {
        AuthAPI.register(body: body) { success, error in
            completion(success, error)
        }
    }
    
    // MARK: - Logout
    func logout(completion: @escaping (Bool, Error?) -> Void) {
        AuthAPI.logout { success, error in
            completion(success, error)
        }
    }
}

