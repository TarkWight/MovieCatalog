//
//  ProfileEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import CoreData

extension ProfileEntity {
    func toDomain() -> Profile {
        Profile(
            id: id,
            nickName: nickName,
            email: email,
            avatarLink: avatarLink,
            name: name,
            birthDate: birthDate,
            gender: Gender(rawValue: gender) ?? .male
        )
    }
}
extension ProfileEntity {
    func update(from profile: Profile) {
        id = profile.id
        nickName = profile.nickName
        email = profile.email
        avatarLink = profile.avatarLink
        name = profile.name
        birthDate = profile.birthDate
        gender = profile.gender.rawValue
    }
}

