//
//  UserRegisterDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 03.01.2025.
//

import Foundation

struct UserRegisterDTO: Encodable {
    let userName: String
    let name: String
    let password: String
    let email: String
    let birthDate: String
    let gender: GenderDTO
}

