//
//  UserInfoViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import Foundation

struct UserInfoViewModel: Equatable, Hashable {
    let userName: String
    let name: String
    let email: String
    let birthDate: Date
    let gender: Gender
}

extension UserInfoViewModel {
    static var `default`: UserInfoViewModel {
        return UserInfoViewModel(
            userName: "",
            name: "",
            email: "",
            birthDate: Date.now,
            gender: .male
        )
    }
}
