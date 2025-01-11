//
//  UserShort.swift
//  MovieCatalog
//
//  Created by Tark Wight on 20.12.2024
//

import Foundation

struct UserShort: Equatable, Hashable {
    let userId: UUID
    let nickName: String?
    let avatar: String?
}
