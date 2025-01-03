//
//  AuthRepository.swift
//  MovieCatalog
//
//  Created by Tark Wight on 20.12.2024.
//

import Foundation

protocol AuthRepository {
    func logIn(credentials: LoginCredentials) async throws
}
